import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: "Passing superhero info",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _superOn = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Passing superhero info"),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Text("off"),
            title:
              CupertinoSwitch(
              value: _superOn,
              onChanged: (bool value) {
                setState(() {
                  _superOn = value;
                });
              },
            ),
            trailing: Text("on"),
          ),
          Text("")
        ],
      ),
    );
  }
}