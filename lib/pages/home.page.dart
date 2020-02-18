import 'package:aog_app/widgets/logo.widget.dart';
import 'package:aog_app/widgets/submit-form.dart';
import 'package:aog_app/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasCtrl = MoneyMaskedTextController();
  var _alcoCtrl = MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedContainer(
          duration: Duration(milliseconds: 1200),
          color: _color,
          child: ListView(
            children: <Widget>[
              Logo(),
              _completed
                  ? Success(
                      result: _resultText,
                      reset: _reset,
                    )
                  : SubmitForm(
                      busy: _busy,
                      submitFunc: _calculate,
                      gasCtrl: _gasCtrl,
                      alcoCtrl: _alcoCtrl,
                    ),
            ],
          ),
        ));
  }

  Future _calculate() {
    double alcool = double.parse(
          _alcoCtrl.text.replaceAll(new RegExp(r'[,.]'), ''),
        ) /
        100;
    double gas = double.parse(
          _gasCtrl.text.replaceAll(new RegExp(r'[,.]'), ''),
        ) /
        100;

    double resp = alcool / gas;

    setState(() {
      _color = Colors.deepOrange;
      _completed = false;
      _busy = true;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (resp >= 0.7) {
          _resultText = "Compensa abastercer com gasolina!";
        } else {
          _resultText = "Compensa abastercer com álcool!";
        }
        _completed = true;
        _busy = false;
      });
    });
  }

  _reset() {
    setState(() {
      _color = Colors.deepPurple;
      _gasCtrl = MoneyMaskedTextController();
      _alcoCtrl = MoneyMaskedTextController();
      _busy = false;
      _completed = false;
    });
  }
}
