vari app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var userList = [];
var typingUsers = {};

app.get('/', function(req, res){
  res.send('<h1>AppCoda - SocketChat Server</h1>');
});


http.listen(3000, function(){
  console.log('Listening on *:3000');
});


// ------------------------------------------------------


// socket 연결 (클라이언트 -> 서버)
io.on('connection', function(clientSocket){
  console.log('a user connected');

  clientSocket.on('disconnect', function(){
    console.log('user disconnected');

    var clientNickname;
    for (var i = 0; i < userList.length; i++) {
      if (userList[i]["id"] == clientSocket.id) {
        userList[i]["isConnected"] = false;
        clientNickname = userList[i]["nickname"];
        break;
      }
    }

    delete typingUsers[clientNickname];
    
    // 유저 목록, 퇴장한 유저, 유저 타이핑 유무 (서버 -> 클라이언트)
    io.emit("userList", userList);
    io.emit("userExitUpdate", clientNickname);
    io.emit("userTypingUpdate", typingUsers);
  });


// 유저 채팅방에서 삭제 (클라이언트 -> 서버)
  clientSocket.on("exitUser", function(clientNickname) {
    for (var i = 0; i < userList.length; i++) {
      if (userList[i]["id"] == clientSocket.id) {
        userList.splice(i, 1);
        break;
      }
    }
    // 퇴장한 유저명 (서버 -> 클라이언트)
    io.emit("userExitUpdate", clientNickname);
  });


// 채팅 메시지 발송 (클라이언트 -> 서버)
  clientSocket.on('chatMessage', function(clientNickname, message){
    var currentDateTime = new Date().toLocaleString();
    delete typingUsers[clientNickname];
    // (서버 -> 클라이언트)
    io.emit("userTypingUpdate", typingUsers);
    io.emit('newChatMessage', clientNickname, message, currentDateTime);
  });


// 연결한 유저 (클라이언트 -> 서버)
  clientSocket.on("connectUser", function(clientNickname) {
      var message = "User " + clientNickname + " was connected.";
      console.log(message);

      var userInfo = {};
      var foundUser = false;
      for (var i = 0; i < userList.length; i++) {
        if (userList[i]["nickname"] == clientNickname) {
          userList[i]["isConnected"] = true
          userList[i]["id"] = clientSocket.id;
          userInfo = userList[i];
          foundUser = true;
          break;
        }
      }

      if (!foundUser) {
        userInfo["id"] = clientSocket.id;
        userInfo["nickname"] = clientNickname;
        userInfo["isConnected"] = true
        userList.push(userInfo);
      }

      // (서버 -> 클라이언트)
      io.emit("userList", userList);
      io.emit("userConnectUpdate", userInfo)
  });

  // 타이핑 시작  (클라이언트 -> 서버)
  clientSocket.on("startType", function(clientNickname){
    console.log("User " + clientNickname + " is writing a message...");
    typingUsers[clientNickname] = 1;

    // (서버 -> 클라이언트)
    io.emit("userTypingUpdate", typingUsers);
  });


  // 타이핑 중단 (클라이언트 -> 서버)
  clientSocket.on("stopType", function(clientNickname){
    console.log("User " + clientNickname + " has stopped writing a message...");
    delete typingUsers[clientNickname];

    // (서버 -> 클라이언트)
    io.emit("userTypingUpdate", typingUsers);
  });
});
