import 'package:flutter/material.dart';
import '../../common/const/color.dart';

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    required this.min,
    required this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required Size sizeWithOverflow,
        required double textScaleFactor,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value}) {
    // ...

    final Canvas canvas = context.canvas;
    // Paint the outer circle of the thumb.
    final outerThumbPaint = Paint()
      ..color = Colors.transparent // 투명한 색상
      ..strokeWidth = 2 // 외곽선 두께
      ..style = PaintingStyle.stroke; // 외곽선 스타일

    canvas.drawCircle(center, thumbRadius, outerThumbPaint);

    // Paint the inner circle of the thumb.
    final innerThumbPaint = Paint()
      ..color = Colors.transparent // 투명한 색상
      ..strokeWidth = 2 // 외곽선 두께
      ..style = PaintingStyle.stroke; // 외곽선 스타일

    canvas.drawCircle(center, thumbRadius, innerThumbPaint);
    // Paint the icon on the thumb.
    const icon = Icons.directions_run;
    final textSpan = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: thumbRadius * 1.5,
        fontFamily: icon.fontFamily,
        color: SERVE_COLOR,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final iconCenter = Offset(
        center.dx - textPainter.width / 2, center.dy - textPainter.height / 2);
    textPainter.paint(canvas, iconCenter);
  }
}
