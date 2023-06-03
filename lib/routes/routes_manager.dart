import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:safe_entry/screens/administrator_screens/administrator_home_page.dart';
import 'package:safe_entry/screens/home_page.dart';
import 'package:safe_entry/screens/log_in_page.dart';
import 'package:safe_entry/screens/organizer_screens/organizer_home_page.dart';
import 'package:safe_entry/screens/security_screens/security_event_details_page.dart';
import 'package:safe_entry/screens/security_screens/security_home_page.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String administratorPage = '/administratorPage';
  static const String organizerPage = '/organizerPage';
  static const String securityPage = '/securityPage';
  static const String securityEventDetailsPage = '/securityEventDetailsPage';
}

class RoutesPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => HomePage()),
    GetPage(name: Routes.login, page: () => LogInPage()),
    GetPage(
        name: Routes.administratorPage, page: () => (AdministratorHomePage())),
    GetPage(name: Routes.organizerPage, page: () => OrganizerHomePage()),
    GetPage(name: Routes.securityPage, page: () => SecurityHomePage()),
    GetPage(
        name: Routes.securityEventDetailsPage,
        page: () => SecurityEventDetailsPage()),
  ];
}
