import 'dart:convert';
import 'dart:io';

import 'package:password_manager/cryptography.dart';
import 'package:path_provider/path_provider.dart';

class DataStorage {

  Cryptography cryptography = Cryptography();

  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/dataStorage.txt");
  }

  Future<List> readWebsites() async {
    try{
      final file = await _localFile;
      file.create();

      final List contents = json.decode(await file.readAsString());

      print("alldata: "+json.encode(contents));

      List data = [];

      for (var element in contents) {
        Map content = {
          "website":element["website"],
          "index":contents.indexOf(element)
        };
        data.add(content);
      }

      return data;
    } catch(e){
      return ["ERROR"];
    }
  }

  Future<Map> readData(int index) async {
    try{
      final file = await _localFile;
      file.create();

      final List contents = json.decode(await file.readAsString());

      Map data = json.decode(cryptography.decrypt(base64.decode(contents[index]["data"])));

      return data;
    } catch(e){
      return {"ERROR":"error"};
    }
  }

  Future<String> readPasswordData(int index) async {
    try{
      final file = await _localFile;
      file.create();

      final List contents = json.decode(await file.readAsString());

      return cryptography.decrypt(base64.decode(contents[index]["password"]));
    } catch(e){
      return "error";
    }
  }

  Future<File> writeData(Map dataReceived) async {
    final file = await _localFile;
    List contents = json.decode(await file.readAsString());

    dataReceived["data"] = base64.encode(cryptography.encrypt(json.encode(dataReceived["data"])));
    dataReceived["password"] = base64.encode(cryptography.encrypt(dataReceived["password"]));

    contents.add(dataReceived);
    String data = json.encode(contents);
    return file.writeAsString(data);
  }

  Future<File> deleteSpecified(int index) async {
      final file = await _localFile;

       List contents = json.decode(await file.readAsString());

      contents.removeAt(index);

      return file.writeAsString(json.encode(contents));
  }


    Future<File> deleteAllData() async{
    final file = await _localFile;
    return file.writeAsString(json.encode([]));
  }

}