type clientToServer =
  | ChatMsg(string)
  | StatusUpdate(string)

type serverToClient =
  | ChatMsg(string)
  | StatusUpdate(string)
  | UsersConnected(int)
