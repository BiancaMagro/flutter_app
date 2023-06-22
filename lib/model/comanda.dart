class Comanda{
  int? codigo;
  String nome;
  int mesa;
  Comanda({this.codigo, required this.nome, required this.mesa});

  Map<String, dynamic> toMap(){
    return {
      'codigo': codigo,
      'nome': nome,
      'mesa': mesa
    };
  }
}