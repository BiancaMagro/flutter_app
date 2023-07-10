import 'package:flutter/material.dart';
import 'package:flutter_app/comandas.dart';
import 'package:flutter_app/db/LoginService.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return home();
  }
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        label: Text("Email", style: TextStyle(fontSize: 22),),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)
                        )
                    )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _senha,
                    obscureText: true,
                    decoration: InputDecoration(
                        label: Text("senha", style: TextStyle(fontSize: 22),),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)
                        )
                    )
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      if(await logarService(_email.text, _senha.text)) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => comandas()
                        ));
                      }else{
                        showDialog(context: context, builder: (BuildContext context){
                          return  AlertDialog(
                            title: Text("Credencias incorretas!"),
                            content: Text("As credencias informadas no login estão incorretas!"),
                          );
                        });
                      }
                    },
                    child: Text("Logar"),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
