// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> medidas = [
    'metros',
    'kilometros',
    'gramos',
    'kilogramos',
    'pies',
    'millas',
    'onzas'
  ];

  late String startM;
  late String endM;

  String endValue = "0";
  // variables para indices

  late int startI;
  late int endI;

  final _formulas = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.0001, 0, 0, 0, 0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0.02835, 3.28084, 0, 0.0625, 1],
  ];

  final ValueController = TextEditingController();

  @override
  void initState() {
    this.startI = 0;
    this.endI = 1;

    this.startM = this.medidas[this.startI];
    this.endM = this.medidas[this.endI];
    super.initState();
  }

  /// no puede terne un valor nulo

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.blueGrey, fontSize: 20);
    const medidaStyle =
        TextStyle(color: Color.fromARGB(255, 4, 61, 108), fontSize: 16);
    //startM = medidas[0];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Medidor",
          ),
        ),
        // ignore: avoid_unnecessary_containers
        body: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
              child: Column(
                children: [
                  const Text(
                    "Valor",
                    style: labelStyle,
                  ),
                  TextField(
                    controller: ValueController,
                    decoration: const InputDecoration(
                        hintText: "Valor Inicial",
                        contentPadding: EdgeInsets.all(8)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "De",
                    style: labelStyle,
                  ),
                  DropdownButton<String>(
                      isExpanded: true,
                      value: startM,

                      ///value para determinar el valor de defecto del array
                      items: medidas.map((m) {
                        return DropdownMenuItem(
                            value: m,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                m,
                                style: medidaStyle,
                              ),
                            )); //importante pasar el value porque despues marca como nullo y se cae
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          startM = value!;
                          startI = medidas.indexOf(startM);
                        });
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Para",
                    style: labelStyle,
                  ),
                  DropdownButton<String>(
                      value: endM,
                      isExpanded: true,

                      ///value para determinar el valor de defecto del array
                      items: medidas.map((m) {
                        return DropdownMenuItem(
                            value: m,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                m,
                                style: medidaStyle,
                              ),
                            )); //importante pasar el value porque despues marca como nullo y se cae
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          endM = value!;
                          endI = medidas.indexOf(endM);
                        });
                      }),
                  // ignore: prefer_const_constructors
                  MaterialButton(
                    onPressed: () {
                      try {
                        final value = double.parse(ValueController.text.trim());
                        setState(() {
                          this.endValue = "${value * _formulas[startI][endI]}";
                        });
                        FocusScope.of(context).requestFocus(FocusNode());
                      } catch (e) {
                        // ignore: avoid_print
                        print("Problemas con la conversion");
                      }
                    },
                    child: const Text("Convertir"),
                  ),
                  // const Spacer(),
                  Text(
                    "res: $endValue ",
                    style: labelStyle,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
