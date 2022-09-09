import 'package:flutter/material.dart';
import 'package:gustavo/models/cliente.dart';
import 'package:gustavo/models/saldo.dart';
import 'package:gustavo/models/transferencias.dart';
import 'package:gustavo/screens/autenticacao/login.dart';
import 'package:gustavo/screens/dashborad/dashboard.dart';
import 'package:provider/provider.dart';

import 'models/transferencia.dart';
import 'screens/transferencia/lista.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Saldo(0),
      ),
      ChangeNotifierProvider(
        create: (context) => Transferencias(),
      ),
      ChangeNotifierProvider(
        create: (context) => Cliente(),
      ),
    ],
    child: ByteBankApp(),
  ));
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Color.fromRGBO(71, 161, 56, 1)),
      ),
      home: login(),
    );
  }
}
