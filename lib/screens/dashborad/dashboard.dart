// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gustavo/models/cliente.dart';
import 'package:gustavo/screens/autenticacao/login.dart';
import 'package:gustavo/screens/dashborad/saldo.dart';
import 'package:gustavo/screens/deposito/formulario.dart';
import 'package:gustavo/screens/transferencia/formulario.dart';
import 'package:gustavo/screens/transferencia/lista.dart';
import 'package:gustavo/screens/transferencia/ultimas.dart';
import 'package:provider/provider.dart';

import '../../models/saldo.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),
      body: Column(
        children: [
          Consumer<Cliente>(builder: (context, cliente, child) {
            if (cliente.nome != null) {
              return Text(
                'Ola, , seu saldo de hoje é: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              );
            }
            return Text(
              'Ola, seu saldo de hoje é: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            );
          }),
          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormularioDeposito();
                    }),
                  );
                },
                child: Text('Receber deposito'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return formularioTransferencia();
                  }));
                },
                child: Text('Nova Transferencia'),
              )
            ],
          ),
          UltimasTransferencias(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return login();
              }), (route) => false);
            },
            child: Text('Sair'),
          )
        ],
      ),
    );
  }
}
