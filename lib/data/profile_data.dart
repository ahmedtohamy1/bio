import 'package:link_in_bio/models/profile.dart';

final profile = Profile(
  name: 'Noppakorn Kaewsalabnil',
  title: 'Computer Science Student',
  location: 'Bangkok, Thailand',
  website: Website(
    text: 'https://pungrumpy.com',
    href: 'https://pungrumpy.com',
  ),
  avatarUrl: 'https://avatars.githubusercontent.com/u/108584943?v=4',
  links: [
    Link(
      icon: 'github',
      text: 'Open Source Projects',
      subtext: 'Check out my contributions and repositories',
      href: 'https://github.com/PunGrumpy',
      category: 'Projects',
      featured: true,
      skills: ['TypeScript', 'React', 'Next.js'],
    ),
    Link(
      icon: 'linkedin',
      text: 'Professional Network',
      subtext: 'Connect with me on LinkedIn',
      href: 'https://th.linkedin.com/in/noppakorn-kaewsalabnil',
      category: 'Work',
      skills: ['Software Development', 'DevOps', 'Cloud Computing'],
    ),
    Link(
      icon: 'calendar',
      text: 'Schedule a Meeting',
      subtext: 'Book a time to connect with me',
      href: 'https://cal.com/pungrumpy',
      category: 'Work',
    ),
  ],
);
