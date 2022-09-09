import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  Editor({
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
  });

  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
