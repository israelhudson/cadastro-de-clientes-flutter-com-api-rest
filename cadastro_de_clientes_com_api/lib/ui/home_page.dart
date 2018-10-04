import 'dart:async';
import 'dart:convert';

import 'package:cadastro_de_clientes_com_api/model/Cliente.dart';
import 'package:cadastro_de_clientes_com_api/ui/cadastro_page.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const requestUrl = "http://ihudapp.xyz/flutter/cad-clientes/cliente-api.php/";
//const requestUrl = "http://192.168.15.5/api-php/cliente-api.php/";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _listaCliente = ["israel","hudson","aragao"];

  Future getData() async {
    http.Response response = await http.get(requestUrl);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    getData().then((map) {
      setState(() {
        //_listaCliente.add(map[0]["nome"]);
        _loadList(map);
      });
    });
  }

  List _loadList(List clientes) {

    debugPrint("resposta MERDAdddd: ${clientes[0]["nome"]}");

    for(int i = 0; i<clientes.length;i++){
      _listaCliente.add(clientes[i]["nome"]);
    }

  }

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
//          getData().then((map) {
//            setState(() {
//              //_listaCliente.add(map[0]["nome"]);
//              _loadList(map);
//            });
//          });

        },//Abrir tela de cadastro
        tooltip: 'Increment',
        child: new Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),

    );
  }
}
