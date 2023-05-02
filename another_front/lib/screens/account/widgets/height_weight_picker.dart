import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import 'package:numberpicker/numberpicker.dart';

class HeightWeightPicker extends StatefulWidget {
  final int initialHeight;
  final int initialWeight;
  final void Function(int height) onHeightChanged;
  final void Function(int weight) onWeightChanged;

  const HeightWeightPicker({
    Key? key,
    required this.initialHeight,
    required this.initialWeight,
    required this.onHeightChanged,
    required this.onWeightChanged,
  }) : super(key: key);

  @override
  State<HeightWeightPicker> createState() => _HeightWeightPickerState();
}

class _HeightWeightPickerState extends State<HeightWeightPicker> {
  late int _heightValue;
  late int _weightValue;

  @override
  void initState() {
    super.initState();
    _heightValue = widget.initialHeight;
    _weightValue = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('　키　',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              NumberPicker(
                value: _heightValue,
                minValue: 100,
                maxValue: 200,
                step: 1,
                haptics: true,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: MAIN_COLOR),
                ),
                textStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                selectedTextStyle: TextStyle(
                    color: MAIN_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                itemHeight: 30,
                onChanged: (value) {
                  setState(() => _heightValue = value);
                  widget.onHeightChanged(value);
                },
              ),
              Text('cm',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 32),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('몸무게',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              NumberPicker(
                value: _weightValue,
                minValue: 30,
                maxValue: 150,
                step: 1,
                haptics: true,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: MAIN_COLOR),
                ),
                textStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                selectedTextStyle: TextStyle(
                  color: MAIN_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                itemHeight: 30,
                onChanged: (value) {
                  setState(() => _weightValue = value);
                  widget.onWeightChanged(value);
                },
              ),
              Text('kg',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 32),
        Text('키 : $_heightValue, 몸무게 : $_weightValue',
            style: TextStyle(color: Colors.white))
      ],
    );
  }
}
