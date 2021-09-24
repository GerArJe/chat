import 'package:flutter/material.dart';

import 'package:chat/models/user.dart';

class ChatService with ChangeNotifier {
  late User userTo;
  late User userFrom;
}
