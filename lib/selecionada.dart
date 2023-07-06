import 'package:flutter/material.dart';
import 'package:flutter_app/db/dataAccessObject.dart';
import 'package:flutter_app/model/comanda.dart';
import 'package:flutter_app/model/pedido.dart';
import 'package:flutter_app/model/produto.dart';

import 'login.dart';

class Selecionada extends StatefulWidget {
  const Selecionada({Key? key, required this.id_comanda}) : super(key: key);
  final int id_comanda;
  @override
  State<Selecionada> createState() => _SelecionadaState();
}

class _SelecionadaState extends State<Selecionada> {
  String _produto = "Coca cola";
  TextEditingController _quantidade = TextEditingController();

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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Novo pedido"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: _produto,
                    items: [
                      DropdownMenuItem<String>(child: Text("Coca cola"), value: "Coca cola"),
                      DropdownMenuItem<String>(child: Text("Pão de queijo"), value: "Pão de queijo"),
                      DropdownMenuItem<String>(child: Text("Café preto"), value: "Café preto"),
                      DropdownMenuItem<String>(child: Text("Bolo de chocolate"), value: "Bolo de chocolate"),
                      DropdownMenuItem<String>(child: Text("Torta de frango"), value: "Torta de frango"),
                      DropdownMenuItem<String>(child: Text("Cupcake"), value: "Cupcake")
                    ],
                    onChanged: (change){
                      setState(() {
                        _produto = change!;
                      });
                    }
                  ),
                  TextFormField(
                    controller: _quantidade,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("Quantidade"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {

                      });
                      Navigator.of(context).pop();
                      DataAccessObject().addPedido(Pedido(codigo_comanda: widget.id_comanda, produto: _produto, quantidade: int.tryParse(_quantidade.text)!));
                    },
                    child: Text("Adicionar")
                  )
                ],
              )
            );
          });
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<Comanda>(
          future: DataAccessObject().getComanda(widget.id_comanda),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(); // Exibir um indicador de progresso enquanto os dados são carregados.
            } else if (snapshot.hasError) {
              return Container(); // Exibir uma mensagem de erro caso ocorra algum problema.
            } else {
              Comanda comanda = snapshot.data!;
              return Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${comanda.mesa}"),
                    Text(comanda.nome!),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: FutureBuilder<List<Pedido>>(
                        future: DataAccessObject().getPedidos(widget.id_comanda),
                        initialData: [],
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState == ConnectionState.waiting) {
                            return Container();// Exibir um indicador de progresso enquanto os dados são carregados.
                          } else if (snapshot2.hasError) {
                            return Container();// Exibir uma mensagem de erro caso ocorra algum problema.
                          } else {
                            List<Pedido> pedidos = snapshot2.data!;
                            return ListView.builder(
                              itemCount: pedidos.length,
                              itemBuilder: (BuildContext context, index) {
                                Pedido pedido = pedidos[index];
                                return ListTile(
                                  title: Text("${pedido.produto}"),
                                  subtitle: Text("X ${pedido.quantidade}"),
                                );
                              },
                            );
                          }
                        }
                      ),
                    ),
                  ],
                )
              );
            }
          },
        ),
      ),
    );
  }
}
