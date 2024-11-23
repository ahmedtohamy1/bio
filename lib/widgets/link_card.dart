import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_in_bio/models/profile.dart';
import 'package:link_in_bio/widgets/custom_cursor.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCard extends StatefulWidget {
  final Link link;

  const LinkCard({super.key, required this.link});

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _iconScaleAnimation;

  // Remove lime accent color and use blue again

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.015,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _iconScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.08,
      end: 0.15,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getIcon(String icon) {
    switch (icon) {
      case 'github':
        return FontAwesomeIcons.github;
      case 'linkedin':
        return FontAwesomeIcons.linkedinIn;
      case 'calendar':
        return FontAwesomeIcons.calendar;
      default:
        return FontAwesomeIcons.link;
    }
  }

  void _launchURL() async {
    final Uri url = Uri.parse(widget.link.href);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
        context
            .findAncestorStateOfType<CustomCursorState>()
            ?.controller
            .forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
        context
            .findAncestorStateOfType<CustomCursorState>()
            ?.controller
            .reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              color: Colors.white.withOpacity(0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: widget.link.featured
                      ? Colors.blue.withOpacity(_opacityAnimation.value + 0.1)
                      : Colors.white.withOpacity(_opacityAnimation.value + 0.1),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: InkWell(
                    onTap: _launchURL,
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Transform.scale(
                scale: _iconScaleAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(isHovered ? 0.05 : 0.02),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: widget.link.featured
                          ? Colors.blue.withOpacity(isHovered ? 0.3 : 0.2)
                          : Colors.white.withOpacity(isHovered ? 0.25 : 0.15),
                    ),
                  ),
                  child: Icon(
                    _getIcon(widget.link.icon),
                    color: widget.link.featured
                        ? Colors.blue.withOpacity(isHovered ? 1 : 0.8)
                        : Colors.white.withOpacity(isHovered ? 1 : 0.8),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.link.text,
                      style: TextStyle(
                        color: Colors.white.withOpacity(isHovered ? 1 : 0.9),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.link.subtext,
                      style: TextStyle(
                        color: Colors.white.withOpacity(isHovered ? 0.7 : 0.5),
                        fontSize: 14,
                      ),
                    ),
                    if (widget.link.skills != null) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: widget.link.skills!.map((skill) {
                          final color =
                              widget.link.featured ? Colors.blue : Colors.white;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    color.withOpacity(isHovered ? 0.2 : 0.15),
                              ),
                            ),
                            child: Text(
                              skill,
                              style: TextStyle(
                                color: color.withOpacity(isHovered ? 0.9 : 0.7),
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
