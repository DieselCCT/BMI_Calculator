import 'package:flutter/cupertino.dart';
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

  String _infoText = "Insert your data";

  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Insert your data";
    });
  }

  void _validade () {

  }

  void _calculate() {
    setState(() {
      double weight = (double.parse(weightController.text));
      double height = (double.parse(heightController.text) / 100);
      double bmi = weight / (height * height);
      if (bmi < 18.6) {
        _infoText = "Under Weight ${bmi.toStringAsPrecision(3)}";
      } else if (bmi >= 18.6 || bmi <= 25){
        _infoText = "Normal Weight ${bmi.toStringAsPrecision(3)}";
      } else {
        _infoText = "Over Weight ${bmi.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetField();
            },
          )
        ],
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_pin_circle,
                  size: 120.0,
                  color: Colors.blueGrey,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Weight (KG)",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25.0),
                  controller: weightController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insert your weight";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Height (cm)",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25.0),
                  controller: heightController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insert your height";
                      }
                    }
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                        _calculate();
                        }
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
    );
  }
}
