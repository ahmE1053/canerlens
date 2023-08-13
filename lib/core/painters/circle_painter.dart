import 'dart:math';

import 'package:flutter/material.dart';

// This is a more complex paint used to draw a kinda of progress bar for the uploading image process
class CirclePainter extends CustomPainter {
  /*
   * it takes the stroke width of the border which is a small value but the only indicator of the animation
   * takes the success value because a green circles appears when the uploading is done
   * and the border length which is the main animation because it kinda goes from 0 to 100%
   * indicating the progress
  */

  final double borderLength, successValue, strokeWidth;

  CirclePainter(this.borderLength, this.successValue, this.strokeWidth)
      : super();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final greyCirclePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      greyCirclePaint,
    );

    final redCirclePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final redCirclePath = Path();

    /*
    * this is a very useful function that generates the circle or a part of it
    * whichever specified in the argument.
    * It takes a start angle which is obviously at the upper start of the circle
    * takes a sweep angle which is the angle the circle that the circle/part of it is generated to
    *
    */

    redCirclePath.addArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      3 * pi / 2,
      borderLength * pi,
    );

    canvas.drawPath(redCirclePath, redCirclePaint);

    //Related to the success circle

    Paint greenPaint = Paint()..color = Colors.greenAccent;

    canvas.drawCircle(
        Offset(radius, radius), successValue * radius, greenPaint);
  }

  //true because of the animation
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
