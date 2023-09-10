import 'package:flutter/material.dart';
import 'package:imc_flutter_calculator/Repository/ImcRepository.dart';

class DadosImc extends StatefulWidget {
  const DadosImc({super.key});

  @override
  State<DadosImc> createState() => _DadosImcState();
}

class _DadosImcState extends State<DadosImc> {
  var imcRepository = ImcRepository();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var teste = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC CALCULATOR"),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Form(
                              child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Calcular IMC",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: pesoController,
                                decoration:
                                    const InputDecoration(labelText: "Peso"),
                              ),
                              TextFormField(
                                controller: alturaController,
                                decoration:
                                    const InputDecoration(labelText: "Altura"),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    double peso =
                                        pesoController.text.toString() == ""
                                            ? 0.0
                                            : double.parse(pesoController.text);
                                    double altura = alturaController.text
                                                .toString() ==
                                            ""
                                        ? 0.0
                                        : double.parse(alturaController.text);

                                    if (altura > 3.0 || altura == 0.0) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const AlertDialog(
                                          title: Text("Error"),
                                          backgroundColor: Colors.redAccent,
                                          content: Text(
                                              "Altura deve ser menor ou igual a 3m"),
                                        ),
                                      );
                                    } else if (peso > 400 || peso == 0.0) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => const AlertDialog(
                                          title: Text("Error"),
                                          backgroundColor: Colors.redAccent,
                                          content: Text(
                                              "Peso deve ser menor ou igual a 400Kg"),
                                        ),
                                      );
                                    } else {
                                      var imc = imcRepository.calculaImc(
                                          peso, altura);
                                      imcRepository.add(peso, altura, imc);
                                      Navigator.pop(context);
                                      setState(() {});
                                      pesoController.text = "";
                                      alturaController.text = "";
                                    }
                                  },
                                  child: const Text("Calcular")),
                            ],
                          )),
                        ),
                      ));
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: imcRepository.imcResults.length,
          itemBuilder: (context, index) {
            return InkWell(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Remover Resultado"),
                          content: const Text(
                              "Você tem certeza que deseja remover o resultado?"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context, "Não"),
                                child: const Text("Não")),
                            TextButton(
                                onPressed: () {
                                  imcRepository.remove(imcRepository
                                      .imcResults[index].id
                                      .toString());
                                  Navigator.pop(context, "Não");
                                  setState(() {});
                                },
                                child: const Text("Sim"))
                          ],
                        ));
              },
              onDoubleTap: () {
                pesoController.text =
                    imcRepository.imcResults[index].peso.toString();
                alturaController.text =
                    imcRepository.imcResults[index].altura.toString();
                showModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              TextField(
                                controller: pesoController,
                                decoration:
                                    const InputDecoration(labelText: "Peso"),
                              ),
                              TextField(
                                controller: alturaController,
                                decoration:
                                    const InputDecoration(labelText: "Altura"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  double peso =
                                      pesoController.text.toString() == ""
                                          ? 0.0
                                          : double.parse(pesoController.text);
                                  double altura =
                                      alturaController.text.toString() == ""
                                          ? 0.0
                                          : double.parse(alturaController.text);
                                  if (altura > 3.0 || altura == 0.0) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const AlertDialog(
                                        title: Text("Error"),
                                        backgroundColor: Colors.redAccent,
                                        content: Text(
                                            "Altura deve ser menor ou igual a 3m"),
                                      ),
                                    );
                                  } else if (peso > 400 || peso == 0.0) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const AlertDialog(
                                        title: Text("Error"),
                                        backgroundColor: Colors.redAccent,
                                        content: Text(
                                            "Peso deve ser menor ou igual a 400Kg"),
                                      ),
                                    );
                                  } else {
                                    imcRepository.edit(
                                        imcRepository.imcResults[index].id
                                            .toString(),
                                        peso,
                                        altura);
                                    pesoController.text = "";
                                    alturaController.text = "";
                                    Navigator.pop(context);
                                    setState(() {});
                                  }
                                },
                                child: const Text("Editar"),
                              )
                            ],
                          ),
                        )));
              },
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Row(
                            children: [
                              Text(
                                "Peso: ${imcRepository.imcResults[index].peso?.toStringAsFixed(1)} Kg",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                  "Altura: ${imcRepository.imcResults[index].altura.toString()} m")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                  "Imc: ${imcRepository.imcResults[index].imc!.toStringAsFixed(1)}"),
                              Text(
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                  imcRepository.imcGrau(
                                      imcRepository.imcResults[index].imc!))
                            ],
                          ),
                        ]),
                      ))),
            );
          }),
    );
  }
}
