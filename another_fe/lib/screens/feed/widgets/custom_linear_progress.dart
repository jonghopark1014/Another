import 'package:flutter/material.dart';

class DistanceBar extends StatelessWidget {
  final String name;
  final double progress;

  const DistanceBar({
    required this.name,
    required this.progress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.start,
          ),
          Stack(
            children: [
              LinearProgressIndicator(
                value: progress / 100,
                minHeight: 12.0,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              Positioned(
                left: progress / 100,
                child: Icon(Icons.directions_run, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            '${progress.toStringAsFixed(1)}%',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ]),
      ],
    );
  }
}