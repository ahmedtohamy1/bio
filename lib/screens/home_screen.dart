import 'package:flutter/material.dart';
import 'package:link_in_bio/data/profile_data.dart';
import 'package:link_in_bio/widgets/link_grid.dart';
import 'package:link_in_bio/widgets/profile_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0A0B), Color(0xFF0A0A0B)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeader(profile: profile),
                LinkGrid(links: profile.links),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
