import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';
import 'package:password_manager/widgets/custom_form_field.dart';

class PasswordDialog extends StatelessWidget {
  const PasswordDialog({
    Key? key,
    required this.label,
    required this.passwordDataController,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final TextEditingController passwordDataController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      backgroundColor: kBackgroundColor,
      title: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
      contentPadding: const EdgeInsets.all(20.0),
      children: [
        CustomFormField(
          controller: passwordDataController,
          isPassword: true,
        ),
        TextButton(onPressed: onTap, child: const Text("Ok")),
      ],
    );
  }
}
