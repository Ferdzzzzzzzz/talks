module type MessagesT = {
  type clientToServer
  type serverToClient
}

module type ClientType = (Messages: MessagesT) =>
{
  type t
  type options

  let io: string => t
  let ioWithOptions: (string, options) => t
  let emit: (t, Messages.clientToServer) => unit
  let on: (t, Messages.serverToClient => unit) => unit
  let onConnect: (t, unit => unit) => unit
  let onDisconnect: (t, unit => unit) => unit
  let disconnect: t => unit
}

module Client: ClientType = (Messages: MessagesT) => {
  type t

  type options = {auth: string}

  @module("socket.io-client") external io: string => t = "io"
  @module("socket.io-client") external ioWithOptions: (string, options) => t = "io"

  @send external _emit: (t, string, 'a) => unit = "emit"

  let emit = (socket, obj: Messages.clientToServer) => _emit(socket, "message", obj)

  @send external _on: (t, string, 'a => unit) => unit = "on"

  let on = (socket, func: Messages.serverToClient => unit) =>
    _on(socket, "message", obj => func(obj))

  let onConnect = (socket, func: unit => unit) => _on(socket, "connect", () => func())
  let onDisconnect = (socket, func: unit => unit) => _on(socket, "disconnect", () => func())

  @send external disconnect: t => unit = "disconnect"
}
