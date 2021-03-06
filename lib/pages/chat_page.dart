import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat/services/chat_service.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  List<ChatMessage> _messages = [];

  bool _typing = false;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('personal-message', _listenMessage);
  }

  void _listenMessage(dynamic payload) {
    print(payload['message']);

    ChatMessage message = ChatMessage(
        text: payload['message'],
        uid: payload['from'],
        animationController: AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 300),
        ));

    setState(() {
      _messages.insert(
        0,
        message,
      );
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userTo = chatService.userTo;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(userTo.name.substring(0, 2),
                  style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(
              height: 3,
            ),
            Text(userTo.name,
                style: TextStyle(color: Colors.black87, fontSize: 12)),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            )),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              height: 50,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    if (text.trim().length > 0) {
                      _typing = true;
                    } else {
                      _typing = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(hintText: 'Send'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Send'),
                      onPressed: _typing
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: _typing
                                ? () =>
                                    _handleSubmit(_textController.text.trim())
                                : null,
                            icon: Icon(
                              Icons.send,
                            )),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: text,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);

    newMessage.animationController.forward();

    setState(() {
      _typing = false;
    });

    socketService.emit('personal-message', {
      'from': authService.user.uid,
      'to': chatService.userTo.uid,
      'message': text,
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketService.socket.off('personal-message');
    super.dispose();
  }
}
