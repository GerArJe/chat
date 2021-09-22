import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

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
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
  }
}
