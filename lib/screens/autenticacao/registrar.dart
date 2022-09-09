import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gustavo/models/cliente.dart';
import 'package:gustavo/screens/dashborad/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

// ignore: use_key_in_widget_constructors
class Registrar extends StatelessWidget {
  // step 1
  final _formUserData = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  // step 2
  final _formUserAddress = GlobalKey<FormState>();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _lougradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  // step 3
  final _formUserAuth = GlobalKey<FormState>();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  get step => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de clinete'),
      ),
      body: Consumer<Cliente>(
        builder: (context, cliente, child) {
          return Stepper(
            currentStep: cliente.stepAtual,
            onStepContinue: () {
              final functions = [
                _salvarSteps1,
                _salvarSteps2,
                _salvarSteps3,
              ];

              return functions[cliente.stepAtual](context);
            },
            onStepCancel: () {
              cliente.stepAtual =
                  cliente.stepAtual > 0 ? cliente.stepAtual - 1 : 0;
            },
            steps: _contruirSteps(context, cliente),
          );
        },
      ),
    );
  }

  _salvarSteps1(context) {
    if (_formUserData.currentState!.validate()) {
      Cliente cliente = Provider.of<Cliente>(context, listen: false);
      cliente.nome = _nomeController.text;

      _proximoStep(context);
    }
  }

  _salvarSteps2(context) {
    if (_formUserAddress.currentState!.validate()) {
      _proximoStep(context);
    }
  }

  _salvarSteps3(context) {
    if (_formUserAuth.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashBoard()),
          (route) => false);
    }
  }

  List<Step> _contruirSteps(context, cliente) {
    List<Step> step = [
      Step(
        title: Text('Seus dados'),
        isActive: cliente.stepAtual >= 0,
        content: Form(
          key: _formUserData,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                controller: _nomeController,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (!value!.contains(" "))
                    return 'Informe pelo Menos um sobrenome!';
                  if (value.length < 3) return 'Nome invalido!';

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                controller: _emailController,
                maxLength: 255,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    Validator.email(value) ? ' email INVALIDO' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CPF',
                ),
                controller: _cpfController,
                maxLength: 14,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfOuCnpjFormatter(),
                ],
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validator.cpf(value) ? ' CPF INVALIDO' : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Celular',
                ),
                controller: _celularController,
                maxLength: 16,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validator.phone(value) ? ' CELULAR INVALIDO' : null,
              ),
              DateTimePicker(
                controller: _nascimentoController,
                type: DateTimePickerType.date,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                dateLabelText: 'Nascimento',
                dateMask: 'dd/MM/yyyy',
                validator: (value) {
                  if (value!.isEmpty) return 'Data Invalida';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      Step(
        title: Text('Endereço'),
        isActive: cliente.stepAtual >= 1,
        content: Form(
          key: _formUserAddress,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CEP',
                ),
                controller: _cepController,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(labelText: 'Estado'),
                items: Estados.listaEstadosSigla.map((String estado) {
                  return DropdownMenuItem(
                    child: Text(estado),
                    value: estado,
                  );
                }).toList(),
                onChanged: (String? novoEstadoSelecionado) {
                  _estadoController.text = novoEstadoSelecionado!;
                },
                validator: (value) {
                  if (value == null) return 'Selecione um estado';

                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Cidade',
                ),
                controller: _cidadeController,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) return 'Cidade Invalido';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Bairro',
                ),
                controller: _bairroController,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) return 'Bairro Invalido';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Lougradouro',
                ),
                controller: _lougradouroController,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) return 'Lougradouro Invalido';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Numero',
                ),
                controller: _numeroController,
                maxLength: 255,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
      Step(
        title: Text('Autenticação'),
        isActive: cliente.stepAtual >= 2,
        content: Form(
          key: _formUserAuth,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                controller: _senhaController,
                maxLength: 255,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 8) return 'senha muito curta';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirmas',
                ),
                controller: _confirmarSenhaController,
                maxLength: 255,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != _senhaController.text)
                    return 'As senhas estão diferente';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    ];

    return step;
  }

  _proximoStep(context) {
    Cliente cliente = Provider.of<Cliente>(context, listen: false);
    irPara(cliente.stepAtual + 1, cliente);
  }

  irPara(int step, cliente) {
    cliente.stepAtual = step;
  }
}
