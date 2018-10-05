import 'dart:async';
import 'dart:convert';

import 'package:cadastro_de_clientes_com_api/model/Cliente.dart';
import 'package:cadastro_de_clientes_com_api/ui/cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

const requestUrl = "http://ihudapp.xyz/flutter/cad-clientes/cliente-api.php/";
//const requestUrl = "http://192.168.15.5/api-php/cliente-api.php/";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Cliente> _listaCliente = [];
  //Cliente cliente;

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
//        Map<String, dynamic> params = Map<String, dynamic>();
//        params["id"] = 5;
//        params["nome"] = "GOKU";
//        params["endereco"] = "GENKI DAMA dnfçaionhfçoirnçvoinrgçioangçanegç";
//        params["contato"] = "1251516";

        _loadList(map);
      });
    });
  }

  List _loadList(List cli) {
    debugPrint("resposta MERLINdddd: ${cli[0]["nome"]}");
    Cliente cliente;
    cliente = new Cliente(cli[0]["nome"], cli[0]["endereco"], cli[0]["contato"]);
    String nome = "fdfd";
    showLongToast(nome);

    for (int i = 0; i < cli.length; i++) {
      //_listaCliente.add(clientes[i]["nome"]);
      //cliente = new Cliente(cli[i]["nome"], cli[i]["endereco"], cli[i]["contato"]);
      cliente = new Cliente("Israel", "fdf", "dfdfd");
      _listaCliente.add(cliente);
      //debugPrint("MAPA : ${clientes[i]["nome"] +" "+ clientes[i]["endereco"] +" "+ clientes[i]["contato"]}");
      debugPrint("MAPA : ${cliente.nome}");

    }

//    for (int i = 0; i < clientes.length; i++) {
//      _clientes.add(cliente);
//    }
//

    //debugPrint("MAPA : ${clientes[0]["nome"]}");
    //showLongToast(clientes.toString());

    //cliente = new Cliente(clientes[0]["nome"], clientes[0]["endereco"], clientes[0]["contato"]);
  }

  void showLongToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Clientes"),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                getData().then((map) {
                  setState(() {
                    _listaCliente.clear();
                    _loadList(map);
                  });
                });
              });
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: _listaCliente.length,
                itemBuilder: (contex, index) {
                  return GestureDetector(
                    child: ListTile(
                      title: Text(_listaCliente[index].nome),),
                    //child: Text(_listaCliente[index]),
                    onTap: () {
                      showLongToast(_listaCliente[index].nome);
                    },
                  );
                }),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {

          getData().then((map) {
            setState(() {
              _listaCliente.clear();
              _loadList(map);
            });
          });

          //cliente = new Cliente("Israel", "fdf", "dfdfd");
//          Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroPage("PASSOU", cliente)))
//          .then((value){
//            getData().then((map) {
//              setState(() {
//                _listaCliente.clear();
//                _loadList(map);
//                debugPrint("MAPA : ${map.toString()}");
//
//              });
//            });
//          });



        }, //Abrir tela de cadastro
        tooltip: 'Increment',
        child: new Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}
