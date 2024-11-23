import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_in_bio/models/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;

  const ProfileHeader({super.key, required this.profile});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String url,
    required String label,
  }) {
    return Tooltip(
      message: label,
      child: IconButton(
        onPressed: () => _launchURL(url),
        icon: Icon(
          icon,
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        hoverColor: Colors.white.withOpacity(0.1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundImage: NetworkImage(profile.avatarUrl),
          ),
          const SizedBox(height: 16),
          Text(
            profile.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            profile.title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            profile.skills,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _launchURL(
                      'https://maps.google.com/?q=${profile.location}'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profile.location,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _launchURL(profile.website.href),
                  child: Row(
                    children: [
                      Icon(
                        Icons.language,
                        size: 16,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profile.website.text,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(
                icon: FontAwesomeIcons.whatsapp,
                url: profile.socials.whatsapp,
                label: 'WhatsApp',
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.linkedin,
                url: profile.socials.linkedin,
                label: 'Linkedin',
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.facebook,
                url: profile.socials.facebook,
                label: 'Facebook',
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.instagram,
                url: profile.socials.instagram,
                label: 'Instagram',
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.github,
                url: profile.socials.github,
                label: 'GitHub',
              ),
              _buildSocialIcon(
                icon: FontAwesomeIcons.telegram,
                url: profile.socials.telegram,
                label: 'Telegram',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
