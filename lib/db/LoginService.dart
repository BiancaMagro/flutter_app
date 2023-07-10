import 'dart:convert';

import 'package:flutter_app/db/OpenDatabasedb.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
Future<bool> logarService(String email, String senha) async{
  var response = await http.post(Uri.parse("http://10.0.2.2:8080/login"),
      body: jsonEncode({"login": email, "senha": senha}),
      headers: {"Content-Type": "application/json"});

  if(response.statusCode == 200){
    final Database db = await getDatabase();
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    print(responseJson['token']);
    await db.update("login", {"token": responseJson['token']}, where: "codigo = ?", whereArgs: [1]);
    return true;
  } else{
    return false;
  }
}