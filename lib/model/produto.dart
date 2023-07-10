class Produto{
  int? codigo;
  String? nome;
  double? valor;
  bool? indcozinha;
  Produto({this.codigo, this.nome, this.valor});

  Map<String, dynamic> toMap(){
    return {
      'id': codigo,
      'nome': nome,
      'preco': valor,
      'indcozinha': indcozinha
    };
  }

  Produto.fromJson(Map<String, dynamic> json):
    codigo = json['id'],
    nome = json['nome'],
    valor = json['preco'],
    indcozinha = json['indcozinha'];
}