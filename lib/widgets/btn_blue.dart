import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonBlue(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 17),
        )),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }
}
