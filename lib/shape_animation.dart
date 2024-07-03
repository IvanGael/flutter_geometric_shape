
import 'package:flutter/material.dart';

class AnimatedShapeTransition extends StatefulWidget {
  const AnimatedShapeTransition({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedShapeTransitionState createState() => _AnimatedShapeTransitionState();
}

class _AnimatedShapeTransitionState extends State<AnimatedShapeTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Shape Transition'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: ShapePainter(_animation.value),
              child: Container(),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ShapePainter extends CustomPainter {
  final double animationValue;

  ShapePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Modify the shape based on the animation value
    double radius = 20 + animationValue * 80;

    Path path = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..addPolygon([
        Offset(size.width / 2 - radius, size.height / 2 - radius),
        Offset(size.width / 2 + radius, size.height / 2 - radius),
        Offset(size.width / 2, size.height / 2 + radius),
      ], true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}