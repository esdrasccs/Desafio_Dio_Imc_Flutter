import '../Model/imcModel.dart';

class ImcRepository {
  final List<IMC> imcResults = <IMC>[];

  calculaImc(double peso, double altura) {
    return (peso / (altura * altura));
  }

  add(double peso, double altura, double imc) {
    var valor = IMC(peso, altura, imc);
    imcResults.add(valor);
  }

  edit(String id, double peso, double altura) {
    double imc = calculaImc(peso, altura);
    imcResults.where((imc) => imc.id == id).first.peso = peso;
    imcResults.where((imc) => imc.id == id).first.altura = altura;
    imcResults.where((imc) => imc.id == id).first.imc = imc;
  }

  remove(String id) {
    var result = imcResults.where((imc) => imc.id == id).first;
    imcResults.remove(result);
  }

  String imcGrau(double imc) {
    if (imc < 16) {
      return "Magreza grave";
    } else if (imc >= 16 && imc < 17) {
      return "Magreza moderada";
    } else if (imc >= 17 && imc < 18.5) {
      return "Magreza leve";
    } else if (imc >= 18.5 && imc < 25) {
      return "Saudavel";
    } else if (imc >= 25 && imc < 30) {
      return "Sobrepeso";
    } else if (imc >= 30 && imc < 35) {
      return "Obesidade Grau I";
    } else if (imc >= 35 && imc < 40) {
      return "Obesidade Grau II (severa)";
    } else if (imc >= 40) {
      return "Obesidade Grau III (mórbida)";
    }
    return "";
  }
}
