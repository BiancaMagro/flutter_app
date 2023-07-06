class Produto{
  int? codigo;
  String? nome;
  double? valor;
  Produto({this.codigo, this.nome, this.valor});

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'nome': nome,
      'valor': valor
    };
  }

  Produto.fromJson(Map<String, dynamic> json):
    codigo = json['codigo'],
    nome = json['nome'],
    valor = json['valor'];
}