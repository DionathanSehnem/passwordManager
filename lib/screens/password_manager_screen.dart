import 'package:flutter/material.dart';
import 'package:password_manager/cryptography.dart';
import 'package:password_manager/data_storage.dart';
import 'package:password_manager/widgets/alert_forms.dart';
import 'package:password_manager/widgets/button_data.dart';

class PasswordManagerScreen extends StatefulWidget {
  const PasswordManagerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordManagerScreen> createState() => _PasswordManagerScreenState();
}

class _PasswordManagerScreenState extends State<PasswordManagerScreen> {
  List<Widget>? dataList;
  @override
  Widget build(BuildContext context) {
    Cryptography cryptography = Cryptography();
    DataStorage dataStorage = DataStorage();

    void refreshScreenDelayed() {
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {});
      });
    }

    void addPasswordPopUp() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertForms(refreshScreen: refreshScreenDelayed);
          }).whenComplete(() {
        refreshScreenDelayed();
      });
    }

    return FutureBuilder<List>(
        future: dataStorage.readWebsites(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final List data = snapshot.data!;
            List<Widget> dataWidgetsList = [];
            for (var element in data) {
              dataWidgetsList.add(ButtonData(
                website: element["website"],
                index: element["index"],
                refresh: refreshScreenDelayed,
              ));
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text("Password Manager"),
                centerTitle: true,
              ),
              body: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
                children: dataWidgetsList,
              ),
              floatingActionButton: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white, shape: const CircleBorder()),
                onPressed: () {
                  addPasswordPopUp();
                },
                child: const Icon(
                  Icons.add,
                  size: 35.0,
                  color: Color(0xFF161626),
                ),
              ),
            );
          }
        });
  }
}