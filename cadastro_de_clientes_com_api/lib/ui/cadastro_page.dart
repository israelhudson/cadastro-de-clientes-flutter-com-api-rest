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

  final Cliente _cliente;

  CadastroPage(this._cliente);

  _CadastroPageState createState() => _CadastroPageState(_cliente);

}

class _CadastroPageState extends State<CadastroPage> {

  TextEditingController nomeController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController contatoController = TextEditingController();
  String _textButton = "";

  final Cliente _cliente;

  _CadastroPageState(this._cliente);

  @override
  void initState() {
    super.initState();

    if(_cliente.id != 0) {
      nomeController.text = _cliente.nome;
      enderecoController.text = _cliente.endereco;
      contatoController.text = _cliente.contato;
      _textButton = "Atualizar";
    }else{
      _textButton = "Cadastrar";
    }


  }

  Future getData() async {
    http.Response response = await http.get(requestUrl);
    return json.decode(response.body);
  }

  Future postData() async {

    Map<String, dynamic> params = Map<String, dynamic>();

    params["nome"] = nomeController.text;
    params["endereco"] = enderecoController.text;
    params["contato"] = contatoController.text;

    http.Response response = await http.post(requestUrl,
        body: json.encode(params));//POST

    print('Response status: ${response.statusCode}');
    return json.decode(response.body);
  }

  Future deleteData(int id) async{
    http.Response response = await http.delete(requestUrl+"/"+id.toString());//DELETE
    print('Response status: ${response.statusCode}');
    return json.decode(response.body);
  }

  Future updateData(int id) async{
    Map<String, dynamic> params = Map<String, dynamic>();

    params["id"] = _cliente.id;
    params["nome"] = nomeController.text;
    params["endereco"] = enderecoController.text;
    params["contato"] = contatoController.text;

    http.Response response = await http.put(requestUrl,
        body: json.encode(params)); //PUT

//    if(int.parse(params["id"]) == _cliente.id){
//      showLongToast("Atualizado com Sucesso");
//      Navigator.pop(context);
//    }else{
//      showLongToast("Erro ao Atualizar");
//    }
    //showLongToast(response.body.toString());
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
        title: Text(_cliente.nome),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){

              if(_cliente.id != 0)
              deleteData(_cliente.id).then((map) {
                //showLongToast(map["id"]);
                if(int.parse(map["id"]) == _cliente.id){
                  showLongToast("Excluido com Sucesso");
                  Navigator.pop(context);
                }else{
                  showLongToast("Erro ao excluir");
                }
              });
              else
                showLongToast("Sem função");
            },
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
                child: Text(_textButton, style: TextStyle(color: Colors.white),),
                color: Colors.deepPurple,
                onPressed: () {
                  if(_cliente.id != 0)
                    updateData(_cliente.id).then((map) {
                      if(int.parse(map["id"].toString()) == _cliente.id){
                        showLongToast("Atualizado com Sucesso");
                        Navigator.pop(context);
                      }else{
                        showLongToast("Erro ao Atualizar");
                      }
                    });
                  else
                    postData().then((map) {
                      if(int.parse(map["id"].toString()) != 0){
                        showLongToast("Cadastrado com Sucesso");
                        Navigator.pop(context);
                      }else{
                        showLongToast("Erro ao Cadastrar");
                      }
                    });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

