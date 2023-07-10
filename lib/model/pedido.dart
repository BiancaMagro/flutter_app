import 'package:flutter_app/model/produto.dart';
import 'package:flutter_app/model/status.dart';

class Pedido{
  int? codigo;
  Produto? produto;
  int? codigo_comanda;
  int? quantidade;
  Status? status;
  Pedido({this.codigo, required this.codigo_comanda, required this.produto, required this.quantidade, this.status});

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'produto': produto?.toMap(),
      'codigo_comanda': codigo_comanda,
      'quantidade': quantidade
    };
  }

  Pedido.fromJson(Map<String, dynamic> json):
      codigo = json['codigo'],
      produto = json['produto'],
      codigo_comanda = json['codigo_comanda'],
      quantidade = json['quantidade'];

}