import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();

  CadastroPage();
}

class _CadastroPageState extends State<CadastroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}

