import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(
          'Don\'t have accout?',
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Create now!',
          style: TextStyle(
              color: Colors.blue[600],
              fontSize: 18,
              fontWeight: FontWeight.bold),
        )
      ],
    ));
  }
}
