class Comanda{
  int? codigo;
  String? nome;
  int? mesa;
  Comanda({this.codigo, this.nome, this.mesa});

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'cliente': nome,
      'mesa': mesa
    };
  }

  Comanda.fromJson(Map<String, dynamic> json):
    codigo = json['codigo'],
    nome = json['cliente'],
    mesa = json['mesa'];
}