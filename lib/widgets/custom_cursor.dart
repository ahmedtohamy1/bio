import 'package:flutter/material.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;
  const CustomCursor({super.key, required this.child});

  @override
  CustomCursorState createState() => CustomCursorState();
}

class CustomCursorState extends State<CustomCursor>
    with SingleTickerProviderStateMixin {
  Offset position = Offset.zero;
  bool isPointerActive = false;
  bool isTouching = false;
  late final AnimationController controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTapDown: (details) {
            setState(() {
              position = details.globalPosition;
              isTouching = true;
            });
            controller.forward();
          },
          onTapUp: (_) {
            setState(() {
              isTouching = false;
            });
            controller.reverse();
          },
          onTapCancel: () {
            setState(() {
              isTouching = false;
            });
            controller.reverse();
          },
          child: MouseRegion(
            onHover: (event) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    position = event.position;
                    if (!isPointerActive) {
                      isPointerActive = true;
                    }
                  });
                }
              });
            },
            onExit: (_) {
              setState(() {
                isPointerActive = false;
              });
            },
            child: RepaintBoundary(child: widget.child),
          ),
        ),
        if (isPointerActive || isTouching)
          TweenAnimationBuilder<Offset>(
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
            tween: Tween<Offset>(
              begin: position,
              end: position,
            ),
            builder: (context, Offset position, child) {
              return Positioned(
                left: position.dx - 20,
                top: position.dy - 20,
                child: RepaintBoundary(
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                              color: Colors.transparent,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
