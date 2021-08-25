import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double IMC = weight / (height * height);

      if (IMC < 18.6) {
        _infoText = "Abaixo do Peso (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 18.6 && IMC < 24.9) {
        _infoText = "Peso Ideal (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 24.9 && IMC < 29.9) {
        _infoText = "Levemente Acima do Peso (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 29.9 && IMC < 34.9) {
        _infoText = "Obesidade Grau I (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 34.9 && IMC < 39.9) {
        _infoText = "Obesidade Grau II (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 40.0) {
        _infoText = "Obesidade Grau III (${IMC.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline, size: 120, color: Colors.green),
              TextFormField(
                //CAMPO DO PESO
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                //CAMPO DA ALTURA
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text(
                      "CALCULAR",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
