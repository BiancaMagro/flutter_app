class Status{
  int codigo;
  Status({required this.codigo});
  Map<String, dynamic> toMap(){
    return {
      "codigo": codigo
    };
  }

  Status.fromJson(Map<String,dynamic> json):
      codigo = json['codigo'];
}