import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';
import 'package:password_manager/data_storage.dart';
import 'package:password_manager/widgets/custom_form_field_with_label.dart';
import 'package:password_manager/widgets/password_dialog.dart';

class AlertForms extends StatelessWidget {
  VoidCallback refreshScreen;

  AlertForms({required this.refreshScreen});

  var websiteController = TextEditingController();
  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  DataStorage dataStorage = DataStorage();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      backgroundColor: kBackgroundColor,
      titlePadding: const EdgeInsets.all(24),
      title: const Text(
        "New password data",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 30.0, right: 30.0),
      children: [
        SizedBox(
          height: 340.0,
          width: 300.0,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              CustomFormFieldWithLabel(hintText: "Website", controller: websiteController),
              CustomFormFieldWithLabel(hintText: "Login", controller: loginController),
              CustomFormFieldWithLabel(
                hintText: "Senha",
                controller: passwordController,
                isPassword: true,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextButton(
              onPressed: () {
                TextEditingController passwordDataController = TextEditingController();
                if (websiteController.text.replaceAll(" ", "").isNotEmpty &&
                    loginController.text.replaceAll(" ", "").isNotEmpty &&
                    passwordController.text.replaceAll(" ", "").isNotEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PasswordDialog(
                            label: "Set password data",
                            passwordDataController: passwordDataController,
                            onTap: () {
                              Map data = {
                                "website": websiteController.text,
                                "password": passwordDataController.text,
                                "data": {
                                  "login": loginController.text,
                                  "password": passwordController.text,
                                }
                              };
                              dataStorage.writeData(data);
                              Navigator.pop(context);
                            });
                      }).whenComplete(() {
                    Navigator.pop(context);
                  });
                } else {
                  print("Faltou preencher algumas coisas hein");
                }
              },
              child: const Text(
                "Ok",
                style: TextStyle(fontSize: 24.0),
              )),
        )
      ],
    );
  }
}