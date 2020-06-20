import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Trip Cost Calculator',
        theme: ThemeData(),
        home: new FuelForm());
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = "";
  final _currencies = [
    'Dollars',
    'Euro',
    'Pounds'
  ]; // array of currencies defined as final, final data type has to have an initializer and cannot be changed
  TextEditingController distanceController =
      TextEditingController(); // this object notifies any listeners and updates the value when the user modifies a textfield
  String _currency =
      'Dollars'; // default currency selected for the dropdown, and the value to update in the state eventually
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
        appBar: AppBar(
          title: Text("Trip Calculator"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: distanceController,
                decoration: InputDecoration(
                    hintText: "e.g. 124",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    labelText: 'Distance',
                    labelStyle: textStyle),
                keyboardType: TextInputType
                    .number, // type of the keyboard this input will use
                // onChanged: (String string) {
                //   setState(() => result = string);
                // }
              ),
              DropdownButton<String>(
                // its a dropdown widget that receives an array of strings
                items: _currencies.map((String value) {
                  // iterates over the currencies array
                  return DropdownMenuItem<String>(
                      // returns an item for each value in the array
                      value: value,
                      child: Text(value));
                }).toList(),
                value: _currency,
                onChanged: (String value) {
                  // super important in order to change the value of the dropdown
                  _onDropdownChanged(value);
                },
              ),
              RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    setState(() {
                      result = distanceController.text;
                    });
                  },
                  child: Text(
                    'Submit',
                    textScaleFactor: 1.5, // makes the text 50% bigger
                  )),
              Text("Result" + result)
            ],
          ),
        ));
  }

  _onDropdownChanged(String value) {
    setState(
        () => this._currency = value); // sets the state with the selected value
  }
}
