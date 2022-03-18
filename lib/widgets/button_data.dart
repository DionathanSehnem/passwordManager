import 'package:flutter/material.dart';
import 'package:password_manager/constants.dart';
import 'package:password_manager/data_storage.dart';
import 'package:password_manager/widgets/custom_form_field.dart';
import 'package:password_manager/widgets/custom_form_field_with_label.dart';
import 'package:password_manager/widgets/password_dialog.dart';

class ButtonData extends StatelessWidget {
  String website;
  int index;
  VoidCallback refresh;

  ButtonData({Key? key, required this.website, required this.index, required this.refresh}) : super(key: key);

  DataStorage dataStorage = DataStorage();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          Map data = await dataStorage.readData(index);
          String dataPassword = await dataStorage.readPasswordData(index);
          TextEditingController passwordDataController = TextEditingController();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return PasswordDialog(label: "Password", passwordDataController: passwordDataController, onTap: () async {
                  if(passwordDataController.text != await dataStorage.readPasswordData(index)){
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: const Color(0xFF161626),
                            ),
                            margin: const EdgeInsets.only(right: 50.0, left: 50.0, top: 160.0, bottom: 160.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(website, style: whiteLabelTitle,),
                                const SizedBox(height: 30.0,),
                                Text("login: " + data["login"], style: whiteLabelText),
                                Text("senha: " + data["password"], style: whiteLabelText),
                                Text("\nsenha dos dados:\n"+ dataPassword, style: whiteLabelText, textAlign: TextAlign.center,),
                                const SizedBox(height: 40.0),
                                TextButton(
                                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                                    onPressed: () {
                                      dataStorage.deleteSpecified(index);
                                      refresh();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: whiteLabelText,
                                    ))
                              ],
                            ),
                          );
                        });
                  }
                },);
              });
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 30.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: const Color(0xAA10101c)),
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0, left: 20.0),
            child: Center(child: Text(website, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)))));
  }
}