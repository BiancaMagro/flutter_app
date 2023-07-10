import 'dart:convert';
import 'package:flutter_app/db/openDatabasedb.dart';
import 'package:flutter_app/model/comanda.dart';
import 'package:flutter_app/model/pedido.dart';
import 'package:flutter_app/model/produto.dart';
import 'package:http/http.dart' as http;

class DataAccessObject{
  addComanda(Comanda comanda) async{
    String token = await getToken();
    var header = {"Content-Type":"application/json", "Authorization": "Bearer ${token}"};
    await http.post(Uri.parse("http://10.0.2.2:8080/pedidos/comandas"),body: jsonEncode(comanda.toMap()), headers: header);
  }
  addPedido(Pedido pedido) async{
    String token = await getToken();
    var header = {"Content-Type":"application/json", "Authorization": "Bearer ${token}"};
    await http.post(Uri.parse("http://10.0.2.2:8080/pedidos"),body: jsonEncode(pedido.toMap()), headers: header);
  }
  Future<List<Comanda>> getComandas() async{
    String token = await getToken();
    var header = {"Content-Type":"application/json", "Authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/pedidos/comandas"), headers: header);
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return responseJson.map<Comanda>((json)=>Comanda.fromJson(json)).toList();
  }
  Future<List<Pedido>> getPedidos(int comanda) async{
    String token = await getToken();
    var header = {"Content-Type":"application/json", "Authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/pedidos/comanda/${comanda}"), headers: header);
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return responseJson.map<Pedido>((json)=>Pedido.fromJson(json)).toList();
  }
  Future<Comanda> getComanda(int id) async{
    String token = await getToken();
    var header = {"Content-Type":"application/json", "Authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/comanda/${id}"), headers: header);
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return Comanda.fromJson(responseJson);
  }
  Future<Pedido> getPedido(int id) async{
    String token = await getToken();
    var header = {"Content-Type":"application/json", "Authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/pedido/${id}"), headers: header);
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return Pedido.fromJson(responseJson);
  }
  Future<Produto> getProduto(int id) async{
    String token = await getToken();
    var header = {"Content-Type":"application/json", "Authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/produtos/byId/${id}"), headers: header);
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return Produto.fromJson(responseJson);
  }
  Future<List<Produto>> getProdutos() async{
    print("\n\n\n\nTESTE ver se ta chegando aqui \n\n\n");
    String token = await getToken();
    var header = {"Content-Type":"application/json", "Authorization": "Bearer ${token}"};
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/produtos"), headers: header);
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    print(responseJson);
    responseJson.map((json){
      print(json.toMap());
    });
    return responseJson.map<Produto>((json)=>Produto.fromJson(json)).toList();
  }
}