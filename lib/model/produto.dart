class Produto{
  int? codigo;
  String nome;
  double valor;
  Produto({this.codigo, required this.nome, required this.valor});

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'nome': nome,
      'valor': valor
    };
  }
}