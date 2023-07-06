import 'dart:convert';

import 'package:flutter_app/model/pedido.dart';
import 'package:http/http.dart' as http;

class PedidoDAO{

  var header = {'Content-Type': 'application/json'};

  addPedido(Pedido pedido) async{
    var url = Uri.parse("http://10.0.2.2:8080/pedido");
    await http.post(url, body: jsonEncode(pedido.toMap()), headers: header);
  }

  Future<List<Pedido>> getPedido() async{
    var url = Uri.parse("http://10.0.2.2:8080/pedido");
    var response = await http.get(url, headers: header);
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return responseJson.map<Pedido>((json) => Pedido.fromJson(json)).toList();
  }
}