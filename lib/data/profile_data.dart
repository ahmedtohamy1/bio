import 'package:link_in_bio/models/profile.dart';

final profile = Profile(
  name: 'Ahmed Tohamy (Agmad)',
  title: 'Software Engineer',
  skills: 'Mobile App Delveloper',
  location: 'Cairo, Egypt',
  website: Website(
    text: 'https://ahmedtohamy.is-a.dev',
    href: 'https://ahmedtohamy.is-a.dev',
  ),
  avatarUrl: 'https://avatars.githubusercontent.com/u/46855301?v=4',
  links: [
    Link(
      icon: 'github',
      text: 'My Projects',
      subtext: 'Check out my contributions and repositories',
      href: 'https://github.com/ahmedtohamy1',
      category: 'Projects',
      featured: true,
      skills: ['Flutter', 'Kotlin', 'Dart Frog', 'Typescript', 'Python'],
    ),
    Link(
      icon: 'linkedin',
      text: 'Professional Network',
      subtext: 'Connect with me on LinkedIn',
      href: 'https://linkedin.com/in/1ahmedtohamy',
      category: 'Work',
      skills: [
        'Software Development',
        'Mobile Development',
      ],
    ),
    Link(
      icon: 'calendar',
      text: 'Schedule a Meeting',
      subtext: 'Book a time to connect with me',
      href: 'https://wa.me/201093480689',
      category: 'Work',
    ),
  ],
  socials: Socials(
    whatsapp: 'https://wa.me/201093480689',
    facebook: 'https://facebook.com/ahmed.tohamy.0',
    instagram: 'https://instagram.com/ahmed.tuhamy',
    github: 'https://github.com/ahmedtohamy1',
    telegram: 'https://t.me/ahmed_tohamy',
    linkedin: 'https://www.linkedin.com/in/1ahmedtohamy/',
  ),
);
