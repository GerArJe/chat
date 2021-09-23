import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/btn_blue.dart';
import 'package:chat/helpers/show_alert.dart';
import 'package:chat/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(
                  title: 'Register',
                ),
                _Form(),
                Labels(
                  route: 'login',
                  title: 'Have account?',
                  subtitle: 'Log In now',
                ),
                Text(
                  'Terms and conditions',
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(
      context,
    );

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeHolder: 'Name',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Password',
            textController: passwordCtrl,
            isPassword: true,
          ),
          ButtonBlue(
            text: 'Create account',
            onPressed: authService.authenticating
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    final registerOk = await authService.register(
                      nameCtrl.text.trim(),
                      emailCtrl.text.trim(),
                      passwordCtrl.text.trim(),
                    );

                    if (registerOk == true) {
                      Navigator.pushReplacementNamed(
                        context,
                        'users',
                      );
                    } else {
                      showAlert(
                        context,
                        'Register error',
                        registerOk,
                      );
                    }
                  },
          ),
        ],
      ),
    );
  }
}
