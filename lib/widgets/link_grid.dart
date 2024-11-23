import 'package:flutter/material.dart';
import 'package:link_in_bio/models/profile.dart';
import 'package:link_in_bio/widgets/link_card.dart';

class LinkGrid extends StatelessWidget {
  final List<Link> links;

  const LinkGrid({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth > 600
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.8,
                    mainAxisExtent: 120,
                  ),
                  itemCount: links.length,
                  itemBuilder: (context, index) {
                    return LinkCard(link: links[index]);
                  },
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: links.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return LinkCard(link: links[index]);
                  },
                );
        },
      ),
    );
  }
}
