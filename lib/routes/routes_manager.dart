import 'package:get/get.dart';
import 'package:safe_entry/screens/home_page.dart';
import 'package:safe_entry/screens/log_in_page.dart';
import 'package:safe_entry/screens/registration_user_page.dart';

// import 'package:userportal/middlewares/logged_in_route_guard_middleware.dart';
class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String registrationUser = '/registrationUser';
}

class RoutesPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomePage()),
    GetPage(name: Routes.login, page: () => LogInPage()),
    GetPage(name: Routes.registrationUser, page: () => RegistrationUserPage()),
  ];
}
