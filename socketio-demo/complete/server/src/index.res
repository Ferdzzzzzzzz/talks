open SocketIOServer

module IO = Server(ChatMessages)

type chatState = {mutable userCount: int}

let state = {
  userCount: 0,
}

let io = IO.createWithOptions(
  IO.makeOptions(
    ~cors={
      origin: "http://localhost:8080",
      methods: ["GET", "POST"],
    },
    (),
  ),
)

io->IO.onConnect(socket => {
  state.userCount = state.userCount + 1
  Js.log("client connected")

  io->IO.emit(UsersConnected(state.userCount))

  socket->IO.onDisconnect(() => {
    state.userCount = state.userCount - 1
    io->IO.emit(UsersConnected(state.userCount))
    Js.log("client disconnected")
  })

  socket->IO.on(msg =>
    switch msg {
    | ChatMsg(msg) => {
        open IO
        socket->broadcast->emitBroadcast(ChatMsg(msg))
      }
    }
  )
})

Js.log("listening on port 4000")
io->IO.listen(4000)
