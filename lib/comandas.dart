import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/db/dataAccessObject.dart';
import 'package:flutter_app/selecionada.dart';

import 'login.dart';
import 'model/comanda.dart';

class comandas extends StatefulWidget {
  const comandas({Key? key}) : super(key: key);

  @override
  State<comandas> createState() => _comandasState();
}

class _comandasState extends State<comandas> {
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _mesa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comandas"),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context)=> login()
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context)=> AlertDialog(
            title: Text("Criar comanda"),
            content: Column(
              children: [
                TextFormField(
                  controller: _mesa,
                  decoration: InputDecoration(
                    label: Text("Mesa")
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _nome,
                  decoration: InputDecoration(
                    label: Text("Nome")
                  ),
                  keyboardType: TextInputType.text,
                ),
                ElevatedButton(
                  onPressed: () async{
                    await DataAccessObject().addComanda(Comanda(nome: _nome.text, mesa: int.tryParse(_mesa.text)!));
                    _nome.clear();
                    _mesa.clear();
                    sleep(Duration(milliseconds: 500));
                    setState(() {

                    });
                    Navigator.of(context).pop();
                  },
                  child: Text("Criar")
                )
              ],
            ),
          ));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Comanda>>(
                initialData: [],
                future: DataAccessObject().getComandas(),
                builder: (context, snapshot){
                  final List<Comanda>? comandas = snapshot.data;
                  return ListView.builder(
                      itemCount: comandas?.length,
                      itemBuilder: (BuildContext context, index){
                        return Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.pinkAccent.shade100,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text((comandas != null)?"Nome: ${comandas[index].nome}": "", style: TextStyle(fontSize: 22)),
                                  Text((comandas != null)?"Mesa: ${comandas[index].mesa}": "", style: TextStyle(fontSize: 22)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: (){
                                        setState(() {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Selecionada(id_comanda: comandas![index].codigo!)));
                                        });
                                      },
                                      child: Text("Selecionar")
                                  ),
                                  ElevatedButton(
                                      onPressed: (){
                                        showDialog(context: context, builder: (context){
                                          return AlertDialog(
                                            title: Text("Confirmar!"),
                                            content: Text("Tem certeza que deseja fechar essa comanda?"),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async{
                                                  await DataAccessObject().fecharComanda(comandas![index].codigo!);
                                                  //sleep(Duration(milliseconds: 500));
                                                  setState(() {

                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Sim")
                                              ),
                                              ElevatedButton(
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Não")
                                              )
                                            ],
                                          );
                                        });
                                      },
                                      child: Text("Fechar Comanda")
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
