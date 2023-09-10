import 'package:flutter/material.dart';

class IMC {
  final String _id = UniqueKey().toString();
  double? _peso;
  double? _altura;
  double? _imc;

  IMC(double peso, double altura, double imc) {
    _peso = peso;
    _altura = altura;
    _imc = imc;
  }

  String? get id => _id;
  double? get peso => _peso;
  double? get altura => _altura;
  double? get imc => _imc;

  set peso(double? peso) {
    _peso = peso;
  }

  set altura(double? altura) {
    _altura = altura;
  }

  set imc(double? imc) {
    _imc = imc;
  }
}
