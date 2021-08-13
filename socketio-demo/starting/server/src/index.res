open SocketIOServer

let httpServer = Http.createServer()

module IO = Server(ChatMessages)

let io = IO.createWithHttpAndOptions(
  httpServer,
  IO.makeOptions(
    ~cors={
      origin: "http://localhost:8080",
      methods: ["GET", "POST"],
    },
    (),
  ),
)

let userCount = 0

type state = {mutable userCount: int}

let currentState = {
  userCount: 0,
}

io->IO.onConnect(socket => {
  Js.log("connection success :) ")

  currentState.userCount = currentState.userCount + 1

  open IO
  io->emit(UsersConnected(currentState.userCount))

  socket->onDisconnect(() => {
    currentState.userCount = currentState.userCount - 1
    io->emit(UsersConnected(currentState.userCount))
    Js.log("Socket disconnected")
  })

  socket->on(msg =>
    switch msg {
    | ChatMsg(msg) => Js.log(msg)
    | StatusUpdate(status) => Js.log(status)
    }
  )
})

httpServer->Http.listen(4000, () => {
  Js.log("listening on port 4000")
})
