import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;

  const ChatMessage({Key? key, required this.text, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: uid == '123' ? _myMessage() : _notMyMessage(),
    );
  }

  _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          left: 50,
          right: 5,
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Color(0xff4D9Ef6),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          left: 5,
          right: 50,
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
