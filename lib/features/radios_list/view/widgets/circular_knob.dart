import 'dart:math';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:radio_app/utils/colors.dart';

class CircularKnob extends StatefulWidget {
  final double currentAngle;
  final void Function(double) onUpdate;
  final double size;
  const CircularKnob({
    Key? key,
    required this.currentAngle,
    required this.onUpdate,
    this.size = 200,
  }) : super(key: key);

  @override
  State<CircularKnob> createState() => _CircularKnobState();
}

class _CircularKnobState extends State<CircularKnob> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final dx = details.delta.dx;
        final dy = details.delta.dy;
        final localPosition = details.localPosition;
        final originOffset = widget.size / 2;

        final initialPoint = Point<double>(
          localPosition.dx - originOffset,
          localPosition.dy - originOffset,
        );
        final endPoint = Point<double>(
          initialPoint.x + dx,
          initialPoint.y + dy,
        );

        final angleDelta = angleBetweenPoints(initialPoint, endPoint);
        widget.onUpdate(widget.currentAngle + angleDelta);
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondaryColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black26,
              offset: Offset(0, 16),
            ),
            BoxShadow(
              inset: true,
              offset: Offset(0, -24),
              blurRadius: 24,
              color: Colors.black38,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondaryColor,
            boxShadow: [
              BoxShadow(
                inset: true,
                offset: Offset(0, 24),
                blurRadius: 24,
                color: Colors.black38,
              ),
            ],
          ),
          alignment: Alignment(
            cos(degToRad(widget.currentAngle)),
            sin(degToRad(widget.currentAngle)),
          ),
          child: Container(
            height: widget.size * .06,
            width: widget.size * .06,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

double radToDeg(double rad) => rad * 180 / pi;
double degToRad(double deg) => deg * pi / 180;

double angleBetweenPoints(Point a, Point b) {
  final deg = radToDeg(atan2(b.y, b.x) - atan2(a.y, a.x));
  if (deg > 180) return deg - 360;
  if (deg < -180) return deg + 360;
  return deg;
}
