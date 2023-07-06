class Pedido{
  int? codigo;
  String? produto;
  int? codigo_comanda;
  int? quantidade;
  Pedido({this.codigo, required this.codigo_comanda, required this.produto, required this.quantidade});

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'produto': produto,
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