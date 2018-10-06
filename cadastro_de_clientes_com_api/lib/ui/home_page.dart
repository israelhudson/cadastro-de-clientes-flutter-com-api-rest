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
  Cliente itemCliente;

  Future getData() async {
    http.Response response = await http.get(requestUrl);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();

    getData().then((map) {
      setState(() {
        _loadList(map);
      });
    });
  }

  List _loadList(List cli) {
    Cliente cliente;

    for (int i = 0; i < cli.length; i++) {
      cliente = new Cliente(int.parse(cli[i]["id"]), cli[i]["nome"], cli[i]["endereco"], cli[i]["contato"]);
      _listaCliente.add(cliente);
    }

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
                      //showLongToast(_listaCliente[index].id.toString()+" - "+_listaCliente[index].nome);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroPage(_listaCliente[index])))
                          .then((value){
                        getData().then((map) {
                          setState(() {
                            _listaCliente.clear();
                            _loadList(map);
                            debugPrint("MAPA : ${map.toString()}");

                          });
                        });
                      });
                    },
                  );
                }),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          itemCliente = new Cliente(0, "Cadastro", "", "");
          Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroPage(itemCliente)))
              .then((value){
            getData().then((map) {
              setState(() {
                _listaCliente.clear();
                _loadList(map);
                debugPrint("MAPA : ${map.toString()}");

              });
            });
          });
        }, //Abrir tela de cadastro
        tooltip: 'Increment',
        child: new Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}
