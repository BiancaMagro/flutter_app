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
    print(status?.toMap());
    return {
      'codigo': codigo,
      'produto': produto?.toMap(),
      'comanda': codigo_comanda,
      'quantidade': quantidade,
      "status": status?.toMap()
    };
  }

  Pedido.fromJson(Map<String, dynamic> json):
      codigo = json['codigo'],
      produto = Produto.fromJson(json['produto']),
      codigo_comanda = json['comanda'],
      quantidade = json['quantidade'],
      status = Status.fromJson(json['status']);

}