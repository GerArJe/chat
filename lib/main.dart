import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/routes/routes.dart';
import 'package:chat/services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }
}
