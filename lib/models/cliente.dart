import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  String _nome = '';
  String _email = '';
  String _celular = '';
  String _cpf = '';
  String _nascimento = '';
  String _cep = '';
  String _estado = '';
  String _cidade = '';
  String _bairro = '';
  String _lougradouro = '';
  String _numero = '';
  String _senha = '';

  String get nome => _nome;
  String get email => _email;
  String get celular => _celular;
  String get cpf => _cpf;
  String get nascimento => _nascimento;
  String get cep => _cep;
  String get estado => _estado;
  String get cidade => _cidade;
  String get bairro => _bairro;
  String get lougradouro => _lougradouro;
  String get numero => _numero;
  String get senha => _senha;

  set nome(String value) {
    _nome = value;

    notifyListeners();
  }

  set email(String value) {
    _email = value;
  }

  set celular(String value) {
    _celular = value;
  }

  set cpf(String value) {
    _cpf = value;
  }

  set nascimento(String value) {
    _nascimento = value;
  }

  set cep(String value) {
    _cep = value;
  }

  set estado(String value) {
    _estado = value;
  }

  set cidade(String value) {
    _cidade = value;
  }

  set bairro(String value) {
    _bairro = value;
  }

  set lougradouro(String value) {
    _lougradouro = value;
  }

  set numero(String value) {
    _numero = value;
  }

  set senha(String value) {
    _senha = value;
  }

// tela de cadastro

  int _stepAtual = 0;

  int get stepAtual => _stepAtual;

  set stepAtual(int value) {
    _stepAtual = value;

    notifyListeners();
  }
}
