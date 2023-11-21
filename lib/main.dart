// ignore_for_file: avoid_print

import 'package:color/pickers/material_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import './pickers/hsv_picker.dart';
// import './pickers/material_picker.dart';
// import './pickers/block_picker.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool lightTheme = true;
  Color currentColor = const Color(0xff304852);
  List<Color> currentColors = [
    const Color(0xff304852),
    const Color(0xffb9dbe6)
  ];
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {
    final foregroundColor =
        useWhiteForeground(currentColor) ? Colors.white : Colors.black;

    return AnimatedTheme(
      data: lightTheme ? ThemeData.light() : ThemeData.dark(),
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => setState(() => lightTheme = !lightTheme),
              icon: Icon(lightTheme
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded),
              label: Text(lightTheme ? 'Night' : '  Day '),
              backgroundColor: currentColor,
              foregroundColor: foregroundColor,
              elevation: 15,
            ),
            appBar: AppBar(
              title: const Text(
                'Simple Color Picker With Opacity',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: currentColor,
              foregroundColor: foregroundColor,
              bottom: const TabBar(
                labelColor: Colors.white,
                tabs: <Widget>[
                  Tab(text: 'Colors'),
                  Tab(text: 'Previews'),
                  Tab(text: 'Slicer'),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SimpleColorPicker(
                  onColorChanged: (Color color) {
                    print('Selected Color: $color');
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
