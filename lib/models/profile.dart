class Profile {
  final String name;
  final String title;
  final String location;
  final Website website;
  final String avatarUrl;
  final List<Link> links;
  final Socials socials;

  Profile({
    required this.name,
    required this.title,
    required this.location,
    required this.website,
    required this.avatarUrl,
    required this.links,
    required this.socials,
  });
}

class Website {
  final String text;
  final String href;

  Website({required this.text, required this.href});
}

class Link {
  final String icon;
  final String text;
  final String subtext;
  final String href;
  final String category;
  final bool featured;
  final List<String>? skills;

  Link({
    required this.icon,
    required this.text,
    required this.subtext,
    required this.href,
    required this.category,
    this.featured = false,
    this.skills,
  });
}

class Socials {
  final String whatsapp;
  final String facebook;
  final String instagram;
  final String github;
  final String telegram;

  Socials({
    required this.whatsapp,
    required this.facebook,
    required this.instagram,
    required this.github,
    required this.telegram,
  });
}
