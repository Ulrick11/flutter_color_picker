import 'dart:math';

import 'package:color/pickers/my_slider.dart';
import 'package:flutter/material.dart';

class SimpleColorPicker extends StatefulWidget {
  final Function(Color) onColorChanged;

  const SimpleColorPicker({
    Key? key,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  SimpleColorPickerState createState() => SimpleColorPickerState();
}

class SimpleColorPickerState extends State<SimpleColorPicker> {
  late Color selectedColor;

  String? selectedBackgroundImagePath;
  String? selectedLogoPath;

  late Offset editedLogoPosition = const Offset(100, 50);
  double indicatorPosition = 0.0;
  double opacityValue = 1.0;

  GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.red;
    editedLogoPosition = const Offset(100, 50);
  }

  void updateColor(double position) {
    double gradientPosition = position / MediaQuery.of(context).size.width;
    gradientPosition = gradientPosition.clamp(0.0, 1.0);
    double angle = gradientPosition * 2 * pi;
    setState(() {
      Color gradientColor =
          HSVColor.fromAHSV(1.0, angle * 180 / pi, 1.0, 1.0).toColor();

      selectedColor = gradientColor.withOpacity(opacityValue);

      widget.onColorChanged(selectedColor);
    });
  }

  void updateOpacity(double opacity) {
    setState(() {
      opacityValue = opacity;

      selectedColor = selectedColor.withOpacity(opacityValue);

      widget.onColorChanged(selectedColor);
    });
  }

  Color calculateTextColor(Color backgroundColor) {
    double brightness = (backgroundColor.red * 299 +
            backgroundColor.green * 587 +
            backgroundColor.blue * 114) /
        1000;

    return brightness > 128 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xffb9dbe6),
          height: 200,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  key: imageKey,
                  padding: const EdgeInsets.all(16),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedColor.withOpacity(opacityValue),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xff5f818a),
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            calculateTextColor(selectedColor),
                            BlendMode.srcATop,
                          ),
                          child: Image.asset(
                            "assets/gitlab1.png",
                            height: 90,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                "Card color",
                style: TextStyle(
                    color: Color(0xff304852), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onPanUpdate: (details) {
              RenderBox renderBox =
                  imageKey.currentContext!.findRenderObject() as RenderBox;

              Offset localPosition =
                  renderBox.globalToLocal(details.globalPosition);

              setState(() {
                indicatorPosition = localPosition.dx;
              });

              updateColor(localPosition.dx);
            },
            child: Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.blue,
                    Colors.indigo,
                    Colors.purple,
                  ],
                  stops: [
                    0.0,
                    0.17,
                    0.33,
                    0.5,
                    0.67,
                    0.83,
                    1.0,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff5f818a),
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: indicatorPosition - 15,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Color picker
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildColorButton(Colors.black),
              _buildColorButton(const Color(0xff4F4F4F)),
              _buildColorButton(const Color(0xff939393)),
              _buildColorButton(const Color(0xff0165FB)),
              _buildColorButton(const Color(0xff458FFF)),
              _buildColorButton(const Color(0xffA6C9FF)),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                'Background Transparency',
                style: TextStyle(
                  color: Color(0xff304852),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        MySlider(
          initialOpacity: opacityValue,
          onOpacityChanged: updateOpacity,
          width: double.infinity,
          height: 40,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              const Text(
                "End",
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
        widget.onColorChanged(selectedColor.withOpacity(opacityValue));
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          border: Border.all(
            color: selectedColor == color
                ? Colors.blue.withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
            width: 5,
            strokeAlign: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xff5f818a),
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
