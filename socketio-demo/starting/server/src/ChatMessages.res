type clientToServer = ChatMsg(string)

type serverToClient =
  | ChatMsg(string)
  | UsersConnected(int)
