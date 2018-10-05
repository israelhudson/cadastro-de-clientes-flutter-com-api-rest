import 'dart:async';
import 'dart:convert';

import 'package:cadastro_de_clientes_com_api/model/Cliente.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

const requestUrl = "http://ihudapp.xyz/flutter/cad-clientes/cliente-api.php/";
//const requestUrl = "http://192.168.15.5/api-php/cliente-api.php/";

class CadastroPage extends StatefulWidget {
  @override

  final String _clienteData;
  final Cliente _cliente;

  CadastroPage(this._clienteData, this._cliente);

  _CadastroPageState createState() => _CadastroPageState(_clienteData, _cliente);

}

class _CadastroPageState extends State<CadastroPage> {

  TextEditingController nomeController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController contatoController = TextEditingController();

//  final Cliente _clienteData;
//
//  _CadastroPageState(this._clienteData);

  final String _clienteData;
  final Cliente _cliente;
//
  _CadastroPageState(this._clienteData, this._cliente);

  @override
  void initState() {
    super.initState();
    showLongToast(_clienteData + " - " + _cliente.nome);
    //nomeController.text = _clienteData.nome;

  }

  Future getData() async {
    http.Response response = await http.get(requestUrl);
    return json.decode(response.body);
  }

  Future postData() async {

    Map<String, dynamic> params = Map<String, dynamic>();
    //params["id"] = this.task.id.toString();
//    params["id"] = 5;
//    params["nome"] = "GOKU";
//    params["endereco"] = "GENKI DAMA dnfçaionhfçoirnçvoinrgçioangçanegç";
//    params["contato"] = "1251516";

    //params["id"] = 5;
    params["nome"] = nomeController.text;
    params["endereco"] = enderecoController.text;
    params["contato"] = contatoController.text;

    http.Response response = await http.post(requestUrl,
        body: json.encode(params));//POST

//    http.Response response = await http.put(requestUrl,
//        body: json.encode(params));//PUT

    //http.Response response = await http.delete(requestUrl+"/5");//DELETE


    print('Response status: ${response.statusCode}');
    return json.decode(response.body);
  }

  void showLongToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context,true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "Nome"
                ),
              ),
              TextFormField(
                controller: enderecoController,
                decoration: InputDecoration(
                  labelText: "Endereco"
                ),
              ),
              TextFormField(
                controller: contatoController,
                decoration: InputDecoration(
                  labelText: "Contato"
                ),
              ),
              RaisedButton(
                child: Text("Cadastrar", style: TextStyle(color: Colors.white),),
                color: Colors.deepPurple,
                onPressed: () {
                  //showLongToast("FOI CARALHO");
                  postData();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

