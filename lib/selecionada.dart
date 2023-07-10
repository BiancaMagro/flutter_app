import 'package:flutter/material.dart';
import 'package:flutter_app/db/dataAccessObject.dart';
import 'package:flutter_app/model/pedido.dart';
import 'package:flutter_app/model/produto.dart';
import 'package:flutter_app/model/status.dart';

import 'login.dart';

class Selecionada extends StatefulWidget {
  const Selecionada({Key? key, required this.id_comanda}) : super(key: key);
  final int id_comanda;
  @override
  State<Selecionada> createState() => _SelecionadaState();
}

class _SelecionadaState extends State<Selecionada> {
  int _produto = 1;
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
              content: StatefulBuilder(
                builder: (context, StateSetter setState){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder<List<Produto>>(
                          initialData: [],
                          future: DataAccessObject().getProdutos(),
                          builder: (context, snapshot){
                            if(snapshot.hasData && !snapshot.hasError && snapshot.data!.isNotEmpty){
                              return DropdownButton<int>(
                                value: _produto,
                                items: snapshot.data?.map((p) {
                                  return DropdownMenuItem<int>(
                                    child: Text("${p.nome}"),
                                    value: p.codigo,
                                  );
                                }).toList(),
                                onChanged: (change){
                                  setState(() {
                                    print(change);
                                    _produto = change!;
                                  });
                                },
                              );
                            }else{
                              return Container();
                            }
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
                          onPressed: () async{
                            setState(() {

                            });
                            Navigator.of(context).pop();
                            Produto prod = await DataAccessObject().getProduto(_produto);
                            if(prod.indcozinha!) {
                              DataAccessObject().addPedido(Pedido(
                                  codigo_comanda: widget.id_comanda,
                                  produto: prod,
                                  quantidade: int.tryParse(_quantidade.text)!,
                                  status: Status(codigo: 1)
                              ));
                            } else{
                              DataAccessObject().addPedido(Pedido(
                                  codigo_comanda: widget.id_comanda,
                                  produto: prod,
                                  quantidade: int.tryParse(_quantidade.text)!,
                                  status: Status(codigo: 3)
                              ));
                            }
                          },
                          child: Text("Adicionar")
                      )
                    ],
                  );
                },
              )
            );
          });
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<List<Pedido>>(
          future: DataAccessObject().getPedidos(widget.id_comanda),
          initialData: [],
          builder: (context, snapshot2) {
            if (!snapshot2.hasData) {
              return Container();// Exibir um indicador de progresso enquanto os dados são carregados.
            } else if (snapshot2.data!.isEmpty) {
              return Container(
                child: Text("Sem pedidos por enquanto!"),
              );// Exibir uma mensagem de erro caso ocorra algum problema.
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
    );
  }
}
