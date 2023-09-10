import 'package:flutter/material.dart';
import 'package:imc_flutter_calculator/Pages/dadosUsuarios.dart';
import 'package:imc_flutter_calculator/Repository/ImcRepository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var imcRepository = ImcRepository();

  @override
  Widget build(BuildContext context) {
    return const DadosImc();
  }
}
