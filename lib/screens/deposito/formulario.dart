import 'package:flutter/material.dart';
import 'package:gustavo/models/saldo.dart';
import 'package:provider/provider.dart';

import '../../components/editor.dart';

const _tituloAppBar = 'Receber deposito';
const _dicaCampoValor = '0.00';
const _rotuloCampoValor = 'Valor';
const _textBotaoConfirmar = 'Confirmar';

class FormularioDeposito extends StatelessWidget {
  FormularioDeposito({Key? key}) : super(key: key);

  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorCampoValor,
              dica: _dicaCampoValor,
              rotulo: _rotuloCampoValor,
              icone: Icons.monetization_on_outlined,
            ),
            ElevatedButton(
                onPressed: () {
                  _criarDeposito(context);
                },
                child: const Text('Confirmar'))
          ],
        ),
      ),
    );
  }

  _criarDeposito(context) {
    final double? valor = double.tryParse(_controladorCampoValor.text);
    final depositoValido = _validaDeposito(valor);

    if (depositoValido) {
      _atualizaEstado(context, valor);
      Navigator.pop(context);
    }
  }

  _validaDeposito(valor) {
    final _campoPreenchido = valor != null;

    return _campoPreenchido;
  }

  _atualizaEstado(context, valor) {
    Provider.of<Saldo>(context, listen: false).adiciona(valor);
  }
}
