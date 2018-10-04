import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

const requestUrl = "http://ihudapp.xyz/flutter/cad-clientes/cliente-api.php/";
//const requestUrl = "http://192.168.15.5/api-php/cliente-api.php/";

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();

  CadastroPage();
}

class _CadastroPageState extends State<CadastroPage> {

  @override
  void initState() {
    super.initState();

  }

  Future getData() async {
    http.Response response = await http.get(requestUrl);
    return json.decode(response.body);
  }

  Future postData() async {
    Map<String, dynamic> jsonMap = {
      'nome': 'Chaves',
      'endereco': 'Rua dos lltapebas',
      'contato': 'ddd',
    };

    Map<String, dynamic> params = Map<String, dynamic>();
    //params["id"] = this.task.id.toString();
    params["id"] = 5;
    params["nome"] = "GOKU";
    params["endereco"] = "GENKI DAMA dnfçaionhfçoirnçvoinrgçioangçanegç";
    params["contato"] = "1251516";

//    http.Response response = await http.post(requestUrl,
//        body: json.encode(params));//POST

//    http.Response response = await http.put(requestUrl,
//        body: json.encode(params));//PUT
          http.Response response = await http.delete(requestUrl+"/5");//DELETE


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
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Cadastrar", style: TextStyle(color: Colors.white),),
            color: Colors.deepPurple,
            onPressed: () {
              showLongToast("FOI CARALHO");
              postData();
            },
          )
        ],
      ),
    );
  }
}

