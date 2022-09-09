// ignore_for_file: prefer_const_constructors

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gustavo/components/mensagem.dart';
import 'package:gustavo/screens/autenticacao/registrar.dart';
import 'package:gustavo/screens/dashborad/dashboard.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class login extends StatelessWidget {
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/bytebank_logo.png',
                  width: 250,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 455,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _construirFormulario(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
  }

  Widget _construirFormulario(context) {
    return Form(
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            'Faça seu Login',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'CPF',
            ),
            maxLength: 14,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfOuCnpjFormatter(),
            ],
            validator: (value) => Validator.cpf(value) ? ' CPF INVALIDO' : null,
            keyboardType: TextInputType.number,
            controller: _cpfController,
          ),
          SizedBox(height: 15),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
            validator: (value) {
              if (value!.isEmpty) return 'informe a senha!';

              return null;
            },
            maxLength: 20,
            keyboardType: TextInputType.text,
            controller: _senhaController,
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  if (_cpfController.text == '405.527.178-60' &&
                      _senhaController.text == 'abc123') {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => DashBoard()),
                      ),
                      (route) => false,
                    );
                  } else {
                    exibirAlerta(
                        content: 'CPF ou Senha invalido!',
                        titulo: 'Atenção',
                        context: context);
                  }
                }
              },
              child: Text('CONTINUAR'),
              style: OutlinedButton.styleFrom(
                primary: Color.fromRGBO(71, 161, 56, 1),
                side: BorderSide(
                  color: Color.fromRGBO(71, 161, 56, 1),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Esqueci a minha senha',
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registrar()),
                );
              },
              style: OutlinedButton.styleFrom(
                primary: Color.fromRGBO(71, 161, 56, 1),
                side: BorderSide(
                  color: Color.fromRGBO(71, 161, 56, 1),
                ),
              ),
              child: Text(
                'Criar uma conta',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
      key: _formkey,
    );
  }
}
