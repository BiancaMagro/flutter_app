import 'package:flutter_app/model/comanda.dart';
import 'package:flutter_app/model/pedido.dart';
import 'package:sqflite/sqflite.dart';

import '../model/produto.dart';
import 'OpenDatabasedb.dart';

class DataAccessObject{

  addPedido(Pedido pedido) async{
    final Database db = await getDatabase();
    db.insert("PEDIDO", pedido.toMap());
  }
  Future<List<Comanda>> getComandas() async{
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query("COMANDA");
    return List.generate(maps.length, (index){
      return Comanda(
          nome: maps[index]['nome'],
          mesa: maps[index]['mesa'],
          codigo: maps[index]['codigo']
      );
    });
  }
  Future<List<Pedido>> getPedidos(int comanda) async{
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query("PEDIDO", where: "codigo_comanda = ?", whereArgs: [comanda]);
    print("Teste");
    print(maps[0]);
    return List.generate(maps.length, (index){
      return Pedido(
          codigo_comanda: maps[index]['codigo_comanda'],
          produto: maps[index]['produto'],
          quantidade: maps[index]['quantidade'],
          codigo: maps[index]['codigo']
      );
    });
  }
  Future<Comanda> getComanda(int id) async{
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query("COMANDA", where: "codigo = ?", whereArgs: [id]);
    return Comanda(nome: maps[0]['nome'], mesa: maps[0]['mesa'], codigo: maps[0]['codigo']);
  }
  Future<Pedido> getPedido(int id) async{
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query("PEDIDO", where: "codigo = ?", whereArgs: [id]);
    return Pedido(codigo_comanda: maps[0]['codigo_comanda'], produto: maps[0]['produto'], quantidade: maps[0]['quantidade'], codigo: maps[0]['codigo']);
  }
}