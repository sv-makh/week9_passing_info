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

class SuperState extends InheritedWidget {
  final bool superheroState;

  SuperState({required this.superheroState, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant SuperState oldWidget) =>
      oldWidget.superheroState != superheroState;

  static bool? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SuperState>()!.superheroState;
}

class _HomePageState extends State<HomePage> {
  bool _superOn = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
            middle: Text("Passing superhero info")),
        child: Material(
          child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 70.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("superOff"),
                      CupertinoSwitch(
                        activeColor: CupertinoColors.black,
                        value: _superOn,
                        onChanged: (bool value) {
                          setState(() {
                            _superOn = value;
                          });
                        },
                      ),
                      Text("superOn")
                    ],
                  ),
                  SuperState(
                      superheroState: _superOn,
                      child: Builder(builder: (BuildContext innerContext) {
                        final superheroState =
                            SuperState.of(innerContext) ?? false;
                        return Image.asset(superheroState
                            ? "assets/images/Spiderman.jpg"
                            : "assets/images/PeterParker.jpg");
                      }))
                ],
              )),
        ));
  }
}
