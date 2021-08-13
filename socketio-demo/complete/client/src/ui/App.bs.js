// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as ChatMessages from "../ChatMessages.bs.js";
import * as SocketClient from "../bindings/SocketClient.bs.js";

function App$SocketView(Props) {
  var match = React.useState(function () {
        return 0;
      });
  var setUsersConnected = match[1];
  React.useEffect((function () {
          var ChatClient = SocketClient.Client(ChatMessages);
          var socket = Curry._1(ChatClient.io, "ws://localhost:4000");
          Curry._2(ChatClient.onConnect, socket, (function (param) {
                  console.log("connection success");
                  
                }));
          Curry._2(ChatClient.onDisconnect, socket, (function (param) {
                  console.log("disconnected");
                  
                }));
          Curry._2(ChatClient.on, socket, (function (msg) {
                  switch (msg.TAG | 0) {
                    case /* ChatMsg */0 :
                    case /* StatusUpdate */1 :
                        console.log(msg._0);
                        return ;
                    case /* UsersConnected */2 :
                        var count = msg._0;
                        return Curry._1(setUsersConnected, (function (param) {
                                      return count;
                                    }));
                    
                  }
                }));
          return (function (param) {
                    return Curry._1(ChatClient.disconnect, socket);
                  });
        }), []);
  return React.createElement("div", undefined, React.createElement("button", undefined, "Update Status"), React.createElement("button", undefined, "Update Status"), React.createElement("div", undefined, "Users Connected -> " + String(match[0])));
}

var SocketView = {
  make: App$SocketView
};

function App(Props) {
  var match = React.useState(function () {
        return false;
      });
  var setShow = match[1];
  var show = match[0];
  return React.createElement("div", undefined, React.createElement("button", {
                  onClick: (function (param) {
                      return Curry._1(setShow, (function (b) {
                                    return !b;
                                  }));
                    })
                }, show ? "Disconnect" : "Connect"), show ? React.createElement(App$SocketView, {}) : null);
}

var make = App;

export {
  SocketView ,
  make ,
  
}
/* react Not a pure module */