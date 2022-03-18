import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';
import 'package:password_manager/screens/password_manager_screen.dart';

void main() => runApp(const PasswordManager());

class PasswordManager extends StatelessWidget {
  const PasswordManager({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kthemeData,
      home: const PasswordManagerScreen(),
    );
  }
}




