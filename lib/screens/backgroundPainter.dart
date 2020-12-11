import 'dart:math';
import 'dart:ui';

import 'package:final_year_project_1_2/config/palette.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

class BackgroundPainter extends CustomPainter {
  // Creating the object once only
  BackgroundPainter({Animation<double> animation})
      : darkPaint = Paint()
          ..color = Palette.dark
          ..style = PaintingStyle.fill,
        buttercupPaint = Paint()
          ..color = Palette.buttercup
          ..style = PaintingStyle.fill,
        cobaltPaint = Paint()
          ..color = Palette.cobalt
          ..style = PaintingStyle.fill,
        liquidAnimation = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        buttercupAnimation = CurvedAnimation(
          parent: animation,
          curve: const Interval(0, 0.7,
              curve: Interval(0, 0.8, curve: SpringCurve())),
          reverseCurve: Curves.linear,
        ),
        darkAnimation = CurvedAnimation(
          parent: animation,
          curve: const Interval(0, 0.8,
              curve: Interval(0, 0.9, curve: SpringCurve())),
          reverseCurve: Curves.easeInCirc,
        ),
        cobaltAnimation = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation);

  final Animation<double> cobaltAnimation;
  final Animation<double> darkAnimation;
  final Animation<double> buttercupAnimation;
  final Animation<double> liquidAnimation;

  final Paint darkPaint;
  final Paint buttercupPaint;
  final Paint cobaltPaint;

  @override
  void paint(Canvas canvas, Size size) {
    print("painting");
    paintCobalt(canvas, size);
    paintDark(canvas, size);
    paintButtercup(canvas, size);
  }

  void paintCobalt(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(0, size.height, cobaltAnimation.value),
    );
    _addPointsToPath(path, [
      Point(
        lerpDouble(0, size.width / 3, cobaltAnimation.value),
        lerpDouble(0, size.height, cobaltAnimation.value),
      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnimation.value),
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnimation.value),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnimation.value),
      ),
    ]);

    canvas.drawPath(path, cobaltPaint);
  }

  void paintDark(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(size.height / 4, size.height / 2, cobaltAnimation.value),
    );
    _addPointsToPath(path, [
      Point(
        size.width / 4,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnimation.value),
      ),
      Point(
        size.width * 3 / 5,
        lerpDouble(size.height / 4, size.height / 2, liquidAnimation.value),
      ),
      Point(
        size.width * 4 / 5,
        lerpDouble(size.height / 6, size.height / 3, darkAnimation.value),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 5, size.height / 4, darkAnimation.value),
      ),
    ]);

    canvas.drawPath(path, darkPaint);
  }

  void paintButtercup(Canvas canvas, Size size) {
    if (buttercupAnimation.value > 0) {
      final path = Path();
      path.moveTo(size.width * 3 / 4, 0);
      path.lineTo(0, 0);
      path.lineTo(
        0,
        lerpDouble(0, size.height / 12, buttercupAnimation.value),
      );
      _addPointsToPath(path, [
        Point(
          size.width / 7,
          lerpDouble(0, size.height / 6, liquidAnimation.value),
        ),
        Point(
          size.width / 3,
          lerpDouble(0, size.height / 10, liquidAnimation.value),
        ),
        Point(
          size.width / 3 * 2,
          lerpDouble(0, size.height / 8, liquidAnimation.value),
        ),
        Point(
          size.width * 3 / 4,
          0,
        ),
      ]);

      canvas.drawPath(path, buttercupPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError("Need 3 or more points to create path.");
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xCoordinates = (points[i].x + points[i + 1].x) / 2;
      final yCoordinates = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(
          points[i].x, points[i].y, xCoordinates, yCoordinates);
    }

    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });

  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
