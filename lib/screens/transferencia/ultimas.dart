import 'package:flutter/material.dart';
import 'package:gustavo/models/transferencias.dart';
import 'package:gustavo/screens/transferencia/lista.dart';
import 'package:provider/provider.dart';

class UltimasTransferencias extends StatelessWidget {
  const UltimasTransferencias({Key? key}) : super(key: key);

  final _titulo = 'Ultimas Tranfesrencias';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _titulo,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Consumer<Transferencias>(builder: (context, transferencias, child) {
          final _ultimasTransferencias =
              transferencias.transferencias.reversed.toList();
          final _quantidade = transferencias.transferencias.length;
          if (_quantidade == 0) {
            return SemTransferenciasCadastradas();
          }
          int tamanho = 2;
          if (_quantidade < 3) {
            tamanho = _quantidade;
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: tamanho,
            shrinkWrap: true,
            itemBuilder: (context, indece) {
              return ItemTransferencia(_ultimasTransferencias[indece]);
            },
          );
        }),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ListaTransferencias();
            }));
          },
          child: Text('Ver todas transferencias'),
        )
      ],
    );
  }
}

class SemTransferenciasCadastradas extends StatelessWidget {
  const SemTransferenciasCadastradas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text('Não foi cadastrado nenhuma transferencia'),
      ),
    );
  }
}
