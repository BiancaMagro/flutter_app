import 'dart:convert';

import 'package:flutter_app/model/comanda.dart';
import 'package:http/http.dart' as http;

class ComandaDAO{

  final url = Uri.parse("http://10.0.2.2:8080/comanda");
  final header = {'Content-Type': 'application/json'};

  addComanda(Comanda comanda) async{
    await http.post(url, body: jsonEncode(comanda.toMap()), headers: header);
  }

  Future<List<Comanda>> getComandas() async{
    var response = await http.get(url, headers: header);
    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonResponse.map<Comanda>((json)=> Comanda.fromJson(json)).toList();
  }
}