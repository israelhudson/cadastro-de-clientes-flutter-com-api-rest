import 'package:cadastro_de_clientes_com_api/ui/cadastro_page.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _listaCliente = ["israel","hudson","aragao"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Clientes"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _listaCliente.length,
              itemBuilder: (contex, index){
                return ListTile(
                  title: Text(_listaCliente[index]),
                );
              }),
          )
        ],
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CadastroPage())

          );
        },//Abrir tela de cadastro
        tooltip: 'Increment',
        child: new Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),

    );
  }
}
