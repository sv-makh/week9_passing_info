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

class HeroCard extends StatelessWidget {
  String _PetersPhoto() {
    var list = <String>[
      "assets/images/PeterParker.jpg",
      "assets/images/PeterParker1.jpg",
      "assets/images/PeterParker2.jpg"
    ];
    return (list..shuffle()).first;
  }

  @override
  build(BuildContext context) {
    final superheroState = SuperState.of(context) ?? false;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 550.0,
          child: Image.asset(superheroState
              ? "assets/images/Spiderman.jpg"
              : _PetersPhoto()),
        ),
        Container(
            width: 200.0,
            height: 100.0,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                color: superheroState
                    ? CupertinoColors.destructiveRed
                    : CupertinoColors.extraLightBackgroundGray),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  superheroState ? "Человек-паук" : "Питер Паркер",
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(superheroState
                    ? "Борец с преступностью"
                    : "Обычный студент")
              ],
            )),
      ],
    );
  }
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
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 70.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("superOff"),
                      CupertinoSwitch(
                        activeColor: CupertinoColors.destructiveRed,
                        value: _superOn,
                        onChanged: (bool value) {
                          setState(() {
                            _superOn = value;
                          });
                        },
                      ),
                      const Text("superOn")
                    ],
                  ),
                  SuperState(superheroState: _superOn, child: HeroCard())
                ],
              )),
        ));
  }
}
