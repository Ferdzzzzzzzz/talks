module Http = {
  type server
  @module("http") external createServer: unit => server = "createServer"
  @send external listen: (server, int, unit => unit) => unit = "listen"
}

module type MessagesType = {
  type clientToServer
  type serverToClient
}

module type ServerType = (Messages: MessagesType) =>
{
  type t
  type room
  type socket

  type corsOptions = {
    origin: string,
    methods: array<string>,
  }
  type options

  let makeOptions: (
    ~pingTimeout: int=?,
    ~pingInterval: int=?,
    ~allowUpgrades: bool=?,
    ~cors: corsOptions=?,
    unit,
  ) => options

  let create: unit => t
  let createWithHttp: Http.server => t
  let createWithHttpAndOptions: (Http.server, options) => t
  let createWithOptions: options => t
  let createWithPort: (int, options) => t

  let onConnect: (t, socket => unit) => unit
  let listen: (t, int) => unit

  let getId: socket => room
  let getRooms: socket => Js.t<'a>
  let getHandshake: socket => Js.t<'a>
  let on: (socket, Messages.clientToServer => unit) => unit
  let onDisconnect: (socket, unit => unit) => unit

  let join: (socket, string) => socket
  let leave: (socket, string) => socket
  let to_: (socket, string) => socket
  let disconnect: (socket, bool) => socket
  let emit: (t, Messages.serverToClient) => unit
  let emitToSocket: (socket, Messages.serverToClient) => unit

  type broadcast
  let broadcast: socket => broadcast
  let emitBroadcast: (broadcast, Messages.serverToClient) => unit
}

module Server: ServerType = (Messages: MessagesType) => {
  type t
  type room = string
  type socket

  type corsOptions = {
    origin: string,
    methods: array<string>,
  }

  type options
  @obj
  external makeOptions: (
    ~pingTimeout: int=?,
    ~pingInterval: int=?,
    ~allowUpgrades: bool=?,
    ~cors: corsOptions=?,
    unit,
  ) => options = ""

  @module("socket.io") @new external create: unit => t = "Server"
  @module("socket.io") @new external createWithOptions: options => t = "Server"
  @module("socket.io") @new external createWithHttp: Http.server => t = "Server"
  @module("socket.io") @new
  external createWithHttpAndOptions: (Http.server, options) => t = "Server"

  @module
  external createWithPort: (int, options) => t = "socket.io"

  @send external _onConnect: (t, string, socket => unit) => unit = "on"
  @send external listen: (t, int) => unit = "listen"

  let onConnect = (server, f) => _onConnect(server, "connection", f)

  // socket usage
  @get external getId: socket => room = "id"
  @get external getRooms: socket => Js.t<'a> = "rooms"
  @get external getHandshake: socket => Js.t<'a> = "handshake"

  @send external _on: (socket, string, Messages.clientToServer => unit) => unit = "on"

  let on = (socket, func: Messages.clientToServer => unit) => _on(socket, "message", func)

  let onDisconnect = (socket, cb) => _on(socket, "disconnect", _ => cb())

  @send external join: (socket, string) => socket = "join"
  @send external leave: (socket, string) => socket = "leave"
  @send external to_: (socket, string) => socket = "to"
  @send external disconnect: (socket, bool) => socket = "disconnect"

  // socket.io/docs/v4/broadcasting-events/
  @send external _emitToAll: (t, string, 'b) => unit = "emit"
  let emit = (io: t, obj: Messages.serverToClient) => _emitToAll(io, "message", obj)

  @send external _emitToSocket: (socket, string, 'b) => unit = "emit"
  let emitToSocket = (socket: socket, obj: Messages.serverToClient) =>
    _emitToSocket(socket, "message", obj)

  type broadcast

  @get external _broadcast: socket => broadcast = "broadcast"
  let broadcast = (socket: socket) => _broadcast(socket)

  @send external _emitBroadcast: (broadcast, string, 'b) => unit = "emit"
  let emitBroadcast = (broadcast: broadcast, obj: Messages.serverToClient) =>
    _emitBroadcast(broadcast, "message", obj)
}
