class Comanda{
  int? codigo;
  String? nome;
  int? mesa;
  Comanda({this.codigo, this.nome, this.mesa});

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'nome': nome,
      'mesa': mesa
    };
  }

  Comanda.fromJson(Map<String, dynamic> json):
    codigo = json['codigo'],
    nome = json['nome'],
    mesa = json['mesa'];
}