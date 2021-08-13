module SocketView = {
  @react.component
  let make = () => {
    let (usersConnected, setUsersConnected) = React.useState(() => 0)

    React.useEffect0(() => {
      open SocketClient
      module ChatClient = Client(ChatMessages)

      let socket = ChatClient.io("ws://localhost:4000")

      socket->ChatClient.onConnect(() => Js.log("connection success"))

      socket->ChatClient.onDisconnect(() => Js.log("disconnected"))

      socket->ChatClient.on(msg =>
        switch msg {
        | ChatMsg(msg) => Js.log(msg)
        | StatusUpdate(status) => Js.log(status)
        | UsersConnected(count) => setUsersConnected(_ => count)
        }
      )

      Some(() => socket->ChatClient.disconnect)
    })

    <div>
      <button> {React.string("Update Status")} </button>
      <button> {React.string("Update Status")} </button>
      <div> {React.string("Users Connected -> " ++ usersConnected->Belt.Int.toString)} </div>
    </div>
  }
}

@react.component
let make = () => {
  let (show, setShow) = React.useState(() => false)

  <div>
    <button onClick={_ => setShow(b => !b)}>
      {if show {
        React.string("Disconnect")
      } else {
        React.string("Connect")
      }}
    </button>
    {if show {
      <SocketView />
    } else {
      React.null
    }}
  </div>
}
