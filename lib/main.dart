import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false, //retira o banner do app em modo debug
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//classe que gerencia o estado da aplicação
class _HomeState extends State<Home> {
  //implementação do controle dos Widgets
  //tem campos de entrada, então precisamos criar objetos de entrada
  //(caixas de texto de entrada, de valores)
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = '';
  //cria um identificador (uma key) do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //implementação da lógica
  void _calculaCombustivelIdeal() {
    setState(() {
      double varAlcool =
          double.parse(alcoolController.text.replaceAll(',', '.'));
      double varGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));
      double proporcao = varAlcool / varGasolina; //70%
      _resultado =
          (proporcao < 0.7) ? 'Abasteça com Álcool' : 'Abasteça com Gasolina';
    });
  }

  void _reset() {
    alcoolController.text = '';
    gasolinaController.text = '';
    setState(() {
      _resultado = '';
      _formKey = GlobalKey<FormState>();
    });
  }
  // fim da lógica

  //criar um builder (construtor)
  @override
  Widget build(BuildContext context) {
    //aqui dentro vão os componentes
    // todo o widget vai retornar alguma coisa
    return Scaffold(
      appBar: AppBar(
        title: Text('Álcool ou Gasolina?',
            style: TextStyle(color: Colors.lightBlue[900])),
        backgroundColor: Colors.grey[300],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.lightBlue[900],
              onPressed: () {
                _reset();
              }),
        ],
      ),
      body: SingleChildScrollView(
        // conforme minha página for aumentando, ele vai rolando a tela
        padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
        //criando um formulário
        child: Form(
          key: _formKey, // identifica o formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 80.0,
                color: Colors.lightBlue[900],
              ),
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number, //tipo de dado aceito
                validator: (value) =>
                    value.isEmpty ? 'Informe o valor do Álcool' : null,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.lightBlue[900]),
                    labelText: 'Valor do Álcool'),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 20),
              ),
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number, //tipo de dado aceito
                validator: (value) =>
                    value.isEmpty ? 'Informe o valor da Gasolina' : null,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.lightBlue[900]),
                    labelText: 'Valor do Gasolina'),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 20),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: Container(
                    height: 50.0,
                    child: RawMaterialButton(
                      onPressed: () {
                        if (_formKey.currentState.validate())
                          _calculaCombustivelIdeal();
                      },
                      child: Text(
                        'Verificar',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      fillColor: Colors.lightBlue[900],
                    ),
                  )),
              Text(
                _resultado,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 23),
              )
            ],
          ),
        ),
      ),
    );
  }
}
