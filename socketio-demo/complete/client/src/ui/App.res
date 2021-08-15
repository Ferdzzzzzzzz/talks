module IO = SocketIOClient.Client(ChatMessages)

type connectionStatus =
  | NotConnected
  | Loading
  | Connected({socket: IO.t})

module ConnectionStatus = {
  @react.component
  let make = (~connectionStatus: connectionStatus, ~userCount: option<int>=?) => {
    open Evergreen

    let (connectionStatusStr, intent) = switch connectionStatus {
    | NotConnected => ("Not Connected", StatusIndicator.Danger)
    | Loading => ("Connecting...", StatusIndicator.Warning)
    | Connected(_) => ("Connected", StatusIndicator.Success)
    }

    let connectionStatus =
      <StatusIndicator.WithIntent intent>
        <Text> connectionStatusStr </Text>
      </StatusIndicator.WithIntent>

    let userCount = switch userCount {
    | None => React.null
    | Some(userCount) => <Text> {"User Count: " ++ userCount->Belt.Int.toString} </Text>
    }

    <div className="status"> connectionStatus userCount </div>
  }
}

module ChatBubble = {
  type position =
    | Left
    | Right

  @react.component
  let make = (~text: string, ~pos: position) => {
    open Evergreen

    let (className, intent) = switch pos {
    | Left => ("chat-bubble-l", Alert.NoIntent)
    | Right => ("chat-bubble-r", Alert.Success)
    }

    <div className> <div className="w"> <Alert title=text hasIcon=false intent /> </div> </div>
  }
}

type chatMessage = {
  message: string,
  isMe: bool,
}

module ChatBubbles = {
  @react.component
  let make = (~messages: array<chatMessage>) => {
    //it's ok to use index as the key if we're not manipulating the array
    <div className="chat-bubbles">
      {messages
      ->Belt.Array.mapWithIndex((index, msg) => {
        let pos = switch msg.isMe {
        | true => ChatBubble.Right
        | false => ChatBubble.Left
        }

        <ChatBubble key={index->Belt.Int.toString} text=msg.message pos />
      })
      ->React.array}
    </div>
  }
}

module Chat = {
  @react.component
  let make = (
    ~setUserCount: option<int> => unit,
    ~setConnectionStatus: connectionStatus => unit,
    ~socket: IO.t,
  ) => {
    let (messages, setMessages) = React.useState(() => [])
    let (text, setText) = React.useState(() => "")

    let handleInputChange = event => {
      let value = ReactEvent.Form.currentTarget(event)["value"]

      setText(_ => value)
    }

    React.useEffect0(() => {
      socket->IO.on(msg =>
        switch msg {
        | ChatMsg(msg) =>
          setMessages(currState =>
            currState->Belt.Array.concat([
              {
                message: msg,
                isMe: false,
              },
            ])
          )
        | UsersConnected(userCount) => setUserCount(Some(userCount))
        }
      )

      Some(
        () => {
          socket->IO.disconnect
          setConnectionStatus(NotConnected)
        },
      )
    })

    open Evergreen
    <div>
      <ChatBubbles messages />
      <div className="input">
        <TextInput onChange={handleInputChange} value=text />
        <div className="empty" />
        <Button
          appearance=Primary
          onClick={_ => {
            socket->IO.emit(ChatMsg(text))

            setMessages(currState =>
              currState->Belt.Array.concat([
                {
                  message: text,
                  isMe: true,
                },
              ])
            )

            setText(_ => "")
          }}>
          "Send"
        </Button>
      </div>
    </div>
  }
}

module Loading = {
  @react.component
  let make = (
    ~setConnectionStatus: connectionStatus => unit,
    ~setUserCount: option<int> => unit,
  ) => {
    React.useEffect0(() => {
      let socket = IO.io("ws://localhost:4000")

      socket->IO.onDisconnect(() => {
        setConnectionStatus(NotConnected)
        setUserCount(None)
      })

      socket->IO.onConnect(() => {
        setConnectionStatus(Connected({socket: socket}))
      })

      None
    })
    React.null
  }
}

@react.component
let make = () => {
  let (connectionStatus, setConnectionStatus) = React.useState(() => NotConnected)
  let (userCount, setUserCount) = React.useState(() => None)
  let (showChat, setShowChat) = React.useState(() => false)

  let chatComponent = switch showChat {
  | false => React.null
  | true =>
    switch connectionStatus {
    | NotConnected => React.null
    | Loading =>
      <Loading
        setUserCount={count => setUserCount(_ => count)}
        setConnectionStatus={status => setConnectionStatus(_ => status)}
      />
    | Connected({socket}) =>
      <Chat
        socket
        setUserCount={count => setUserCount(_ => count)}
        setConnectionStatus={status => setConnectionStatus(_ => status)}
      />
    }
  }

  let (buttonStr, intent) = switch showChat {
  | true => ("Disconnect", Evergreen.Button.NoIntent)
  | false => ("Connect", Evergreen.Button.Success)
  }

  open Evergreen

  <div>
    <Button
      intent
      onClick={_ => {
        setConnectionStatus(_ => Loading)
        setShowChat(b => !b)
      }}>
      buttonStr
    </Button>
    <div className="main"> <ConnectionStatus connectionStatus ?userCount /> chatComponent </div>
  </div>
}
