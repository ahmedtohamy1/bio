import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:link_in_bio/data/profile_data.dart';
import 'package:link_in_bio/widgets/floating_logos.dart';
import 'package:link_in_bio/widgets/link_grid.dart';
import 'package:link_in_bio/widgets/profile_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<Offset> _gridSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:
          const Duration(milliseconds: 800), // Reduced duration for smoothness
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _gridSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF050607).withOpacity(0.98),
                  const Color(0xFF020203).withOpacity(0.98),
                ],
              ),
            ),
          ),
          // Background blur
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 100, sigmaY: 100), // Reduced blur for performance
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0A0C12).withOpacity(0.02),
                    const Color(0xFF030405).withOpacity(0.03),
                  ],
                ),
              ),
            ),
          ),
          // Floating logos
          const FloatingLogosWidget(),
          // Main content
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width > 1200
                      ? MediaQuery.of(context).size.width * 0.12
                      : 24.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: ListView(
                    physics:
                        const ClampingScrollPhysics(), // Smooth scrolling physics
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _headerSlideAnimation,
                          child: ProfileHeader(profile: profile),
                        ),
                      ),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _gridSlideAnimation,
                          child: LinkGrid(links: profile.links),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
