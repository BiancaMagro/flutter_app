import 'dart:convert';

import 'package:flutter_app/model/produto.dart';
import 'package:http/http.dart' as http;

class ProdutoDAO{
  Future<List<Produto>> getProdutos() async {
    var url = Uri.parse("http://10.0.2.2:8080/produto");
    var response = await http.get(url, headers: {'Content-Type': 'application/json'});
    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonResponse.map<Produto>((json)=> Produto.fromJson(json)).toList();
  }

  Future<Produto> getProduto(int id) async{
    var url = Uri.parse("http://10.0.2.2:8080/produto/${id}");
    var response = await http.get(url, headers: {'Content-Type': 'application/json'});
    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return Produto.fromJson(jsonResponse);
  }
}