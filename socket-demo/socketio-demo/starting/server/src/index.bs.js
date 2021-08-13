// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Http from "http";
import * as Curry from "rescript/lib/es6/curry.js";
import * as ChatMessages from "./ChatMessages.bs.js";
import * as SocketIOServer from "./bindings/SocketIOServer.bs.js";

var httpServer = Http.createServer();

var IO = SocketIOServer.Server(ChatMessages);

var io = Curry._2(IO.createWithHttpAndOptions, httpServer, Curry._5(IO.makeOptions, undefined, undefined, undefined, {
          origin: "http://localhost:8080",
          methods: [
            "GET",
            "POST"
          ]
        }, undefined));

var currentState = {
  userCount: 0
};

Curry._2(IO.onConnect, io, (function (socket) {
        console.log("connection success :) ");
        currentState.userCount = currentState.userCount + 1 | 0;
        Curry._2(IO.emit, io, {
              TAG: /* UsersConnected */2,
              _0: currentState.userCount
            });
        Curry._2(IO.onDisconnect, socket, (function (param) {
                currentState.userCount = currentState.userCount - 1 | 0;
                Curry._2(IO.emit, io, {
                      TAG: /* UsersConnected */2,
                      _0: currentState.userCount
                    });
                console.log("Socket disconnected");
                
              }));
        return Curry._2(IO.on, socket, (function (msg) {
                      console.log(msg._0);
                      
                    }));
      }));

httpServer.listen(4000, (function (param) {
        console.log("listening on port 4000");
        
      }));

var userCount = 0;

export {
  httpServer ,
  IO ,
  io ,
  userCount ,
  currentState ,
  
}
/* httpServer Not a pure module */