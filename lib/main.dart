import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider used in order to be listen for data/changes on data
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: MyText(),
          ),
          body: Level1(),
        ),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Level2(),
    );
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyTextField(),
        Level3(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(Provider.of<Data>(context).data),
    );
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //EG: of how to listen/receive data from the provider
    return Text(Provider.of<Data>(context).data);
  }
}

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //'myData' is set as a listener of the Provider
    //and will rebuild itself when 'notifyListeners()' is called
    final myData = Provider.of<Data>(context);
    return TextField(
      onChanged: (newText) {
        myData.changeString(newText);
      },
    );
  }
}

//Data class extending 'ChangeNotifier' -> which allows interaction with 'Provider'
class Data extends ChangeNotifier {
  String data = 'Some Data';
  //Necessary function to set the variable value
  //'notifyListeners()' is a must in order for Widgets listening be able to rebuild themselves
  //with the variable's new value
  void changeString(String newString) {
    data = newString;
    notifyListeners();
  }
}
