import 'package:flutter/material.dart';
import 'package:flutter_app/comandas.dart';

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
                    obscureText: true,
                    decoration: InputDecoration(
                        label: Text("senha", style: TextStyle(fontSize: 22),),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)
                        )
                    )
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => comandas()
                      ));
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
