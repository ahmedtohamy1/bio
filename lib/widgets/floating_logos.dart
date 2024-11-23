import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FloatingLogosWidget extends StatefulWidget {
  const FloatingLogosWidget({super.key});

  @override
  State<FloatingLogosWidget> createState() => _FloatingLogosWidgetState();
}

class _FloatingLogosWidgetState extends State<FloatingLogosWidget>
    with SingleTickerProviderStateMixin {
  static const int _logoCount = 25;
  static const Duration _animationDuration = Duration(seconds: 12);

  late final AnimationController _controller;
  final List<FloatingLogo> _logos = List.generate(
    _logoCount,
    (_) => FloatingLogo(),
  );

  final Map<LogoType, ui.Image?> _logoImages = {};
  bool _imagesLoaded = false;

  Future<void> _loadImages() async {
    const assetPaths = {
      LogoType.flutter: 'assets/logos/flutter.png',
      LogoType.dart: 'assets/logos/dart.png',
      LogoType.android: 'assets/logos/android.png',
      LogoType.windows: 'assets/logos/windows.png',
      LogoType.kotlin: 'assets/logos/kotlin.png',
      LogoType.google: 'assets/logos/google.png',
    };

    try {
      for (final entry in assetPaths.entries) {
        final ByteData data = await rootBundle.load(entry.value);
        final Uint8List bytes = data.buffer.asUint8List();
        final ui.Codec codec = await ui.instantiateImageCodec(bytes);
        final ui.FrameInfo fi = await codec.getNextFrame();
        _logoImages[entry.key] = fi.image;
      }

      if (mounted) {
        setState(() => _imagesLoaded = true);
      }
    } catch (e) {
      debugPrint('Error loading logo images: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..repeat();

    _loadImages();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_imagesLoaded) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CustomPaint(
        painter: LogoPainter(
          logos: _logos,
          progress: _controller.value,
          logoImages: _logoImages,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class FloatingLogo {
  static const double _minSize = 15;
  static const double _maxSize = 35;
  static const double _minSpeed = 0.02;
  static const double _maxSpeed = 0.07;
  static const double _minOpacity = 0.03;
  static const double _maxOpacity = 0.12;
  static const double _minBlur = 0.2;
  static const double _maxBlur = 0.45;

  final double x = Random().nextDouble();
  final double y = Random().nextDouble();
  final double size = Random().nextDouble() * (_maxSize - _minSize) + _minSize;
  final double speed =
      Random().nextDouble() * (_maxSpeed - _minSpeed) + _minSpeed;
  final double opacity =
      Random().nextDouble() * (_maxOpacity - _minOpacity) + _minOpacity;
  final double blur = Random().nextDouble() * (_maxBlur - _minBlur) + _minBlur;
  final LogoType type =
      LogoType.values[Random().nextInt(LogoType.values.length)];
  final double rotation = Random().nextDouble() * 2 * pi;
}

enum LogoType {
  flutter,
  dart,
  android,
  windows,
  kotlin,
  google,
}

class LogoPainter extends CustomPainter {
  final List<FloatingLogo> logos;
  final double progress;
  final Map<LogoType, ui.Image?> logoImages;

  const LogoPainter({
    required this.logos,
    required this.progress,
    required this.logoImages,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw each logo twice to create seamless transition
    for (final logo in logos) {
      // First instance
      final y1 = (logo.y + progress * logo.speed) % 1.0;
      _drawLogo(canvas, size, logo, y1);

      // Second instance for seamless transition
      final y2 = y1 - 1.0;
      _drawLogo(canvas, size, logo, y2);
    }
  }

  void _drawLogo(
      Canvas canvas, Size size, FloatingLogo logo, double yPosition) {
    final image = logoImages[logo.type];
    if (image == null) return;

    canvas.save();

    final center = Offset(logo.x * size.width, yPosition * size.height);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(logo.rotation);

    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: logo.size,
      height: logo.size,
    );

    final paint = Paint()
      ..imageFilter = ui.ImageFilter.blur(
        sigmaX: logo.blur,
        sigmaY: logo.blur,
      )
      ..colorFilter = ColorFilter.mode(
        Colors.white.withOpacity(logo.opacity),
        BlendMode.srcIn,
      );

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      rect,
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(LogoPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
