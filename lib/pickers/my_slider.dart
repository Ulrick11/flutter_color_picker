// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  final double initialOpacity;
  final Function(double) onOpacityChanged;
  final double? width;
  final double? height;

  const MySlider({
    Key? key,
    required this.initialOpacity,
    required this.onOpacityChanged,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  MySliderState createState() => MySliderState();
}

class MySliderState extends State<MySlider> {
  double _sliderValue = 512;
  @override
  void initState() {
    super.initState();
    _sliderValue = widget.initialOpacity * 10000;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 16,
        thumbShape: const CustomSliderThumbShape(
          enabledThumbRadius: 16,
          borderSideColor: Colors.white,
        ),
        overlayColor: Colors.transparent,
      ),
      child: Slider(
        activeColor: Color(0xff304852),
        inactiveColor: Colors.blueGrey.withOpacity(0.2),
        thumbColor: Color(0xff304852),
        value: _sliderValue,
        min: 50,
        max: 10000,
        onChanged: (value) {
          setState(() {
            _sliderValue = value;
          });
        },
        label: '$_sliderValue',
        divisions: 100,
        onChangeEnd: (value) {
          widget.onOpacityChanged(value / 10000);
        },
      ),
    );
  }
}

class CustomSliderThumbShape extends RoundSliderThumbShape {
  @override
  final double enabledThumbRadius;
  final Color borderSideColor;

  const CustomSliderThumbShape({
    required this.enabledThumbRadius,
    required this.borderSideColor,
  });

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = borderSideColor
      ..strokeWidth = 7.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, enabledThumbRadius, paint);

    super.paint(
      context,
      center,
      activationAnimation: activationAnimation,
      enableAnimation: enableAnimation,
      isDiscrete: isDiscrete,
      labelPainter: labelPainter,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      textDirection: textDirection,
      value: value,
      textScaleFactor: textScaleFactor,
      sizeWithOverflow: sizeWithOverflow,
    );
  }
}
