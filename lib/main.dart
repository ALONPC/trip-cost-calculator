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
  final double _formDistance = 5.0;
  final _currencies = [
    'Dollars',
    'Euro',
    'Pounds'
  ]; // array of currencies defined as final, final data type has to have an initializer and cannot be changed
  // the controller approach is different from state since it will control the result value when we hit submit and not in onchanged. This object notifies any listeners and updates the value when the user modifies a textfield
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
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
              Padding(
                  padding: EdgeInsets.only(
                      top: _formDistance, bottom: _formDistance),
                  child: TextField(
                    controller:
                        distanceController, // when we use the controller appreach instead of the onChanged, this is super important in order to let the textInput know the link between the result value and the submit button
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
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: _formDistance, bottom: _formDistance),
                  child: TextField(
                    controller: avgController,
                    decoration: InputDecoration(
                        hintText: "e.g. 17",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        labelText: 'Distance per unit',
                        labelStyle: textStyle),
                    keyboardType: TextInputType.number,
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: _formDistance, bottom: _formDistance),
                  child: Row(children: <Widget>[
                    Expanded(
                        // use expanded widget to make the child widget 'feel' all the available space
                        child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                          hintText: "e.g. 1.65",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          labelText: 'Price',
                          labelStyle: textStyle),
                      keyboardType: TextInputType.number,
                    )),
                    Container(width: _formDistance * 5),
                    Expanded(
                      child: DropdownButton<String>(
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
                    )
                  ])),
              Row(children: <Widget>[
                Expanded(
                    child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          setState(() {
                            result = _calculate();
                          });
                        },
                        child: Text(
                          'Submit',
                          textScaleFactor: 1.5, // makes the text 50% bigger
                        ))),
                Expanded(
                    child: RaisedButton(
                        color: Theme.of(context).buttonColor,
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5, // makes the text 50% bigger
                        ))),
              ]),
              Text(result)
            ],
          ),
        ));
  }

  void _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
    setState(() {
      result = '';
    });
  }

  void _onDropdownChanged(String value) {
    setState(
        () => this._currency = value); // sets the state with the selected value
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _consumption = double.parse(avgController.text);
    double _fuelCost = double.parse(priceController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result =
        'The total cost of your trip is ${_totalCost.toStringAsFixed(2)} $_currency'; // interpolation with methods in between is used with brackets, when it only shows one value, it can be written as $value
    return _result;
  }
}
