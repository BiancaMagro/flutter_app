import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async{
  final String path = join(await getDatabasesPath(), 'db');

  return openDatabase(
      path,
      onCreate: (db, version){
        db.execute("CREATE TABLE PRODUTO (codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, valor INTEGER)");
        db.execute("CREATE TABLE COMANDA (codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, mesa INTEGER)");
        db.execute("CREATE TABLE PEDIDO (codigo INTEGER PRIMARY KEY AUTOINCREMENT, produto INTEGER, codigo_comanda INTEGER, quantidade INTEGER)");
      }, version: 1);
}