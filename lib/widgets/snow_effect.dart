import 'dart:math';

import 'package:flutter/material.dart';

class SnowflakeWidget extends StatefulWidget {
  const SnowflakeWidget({super.key});

  @override
  State<SnowflakeWidget> createState() => _SnowflakeWidgetState();
}

class _SnowflakeWidgetState extends State<SnowflakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Snowflake> _snowflakes = List.generate(
    40,
    (index) => Snowflake(),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SnowPainter(
            _snowflakes,
            _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Snowflake {
  final double x = Random().nextDouble();
  final double y = Random().nextDouble();
  final double size = Random().nextDouble() * 3.0 + 1.5;
  final double speed = Random().nextDouble() * 0.05 + 0.02;
  final double opacity = Random().nextDouble() * 0.15 + 0.03;
}

class SnowPainter extends CustomPainter {
  final List<Snowflake> snowflakes;
  final double progress;

  SnowPainter(this.snowflakes, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (var snowflake in snowflakes) {
      final y = (snowflake.y + progress * snowflake.speed) % 1.0;
      paint.color = Colors.white.withOpacity(snowflake.opacity);
      canvas.drawCircle(
        Offset(snowflake.x * size.width, y * size.height),
        snowflake.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(SnowPainter oldDelegate) => true;
}
