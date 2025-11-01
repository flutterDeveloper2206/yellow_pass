
import 'package:yellow_pass/presentation/dashboard_screen/binding/dashboard_screen_binding.dart';
import 'package:yellow_pass/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:yellow_pass/presentation/home_screen/binding/home_screen_binding.dart';
import 'package:yellow_pass/presentation/home_screen/home_screen.dart';
import 'package:yellow_pass/presentation/login_screen/binding/login_screen_binding.dart';
import 'package:yellow_pass/presentation/login_screen/login_screen.dart';
import 'package:yellow_pass/presentation/network_screen/binding/network_screen_binding.dart';
import 'package:yellow_pass/presentation/network_screen/network_screen.dart';
import 'package:yellow_pass/presentation/notification_screen/binding/notification_screen_binding.dart';
import 'package:yellow_pass/presentation/notification_screen/notification_screen.dart';
import 'package:yellow_pass/presentation/onboarding_screen/binding/onboarding_screen_binding.dart';
import 'package:yellow_pass/presentation/profile_screen/binding/profile_screen_binding.dart';
import 'package:yellow_pass/presentation/profile_screen/profile_screen.dart';
import 'package:yellow_pass/presentation/register_screen/binding/register_screen_binding.dart';
import 'package:yellow_pass/presentation/register_screen/register_screen.dart';
import 'package:yellow_pass/presentation/welcome_screen/binding/welcome_screen_binding.dart';
import 'package:get/get.dart';
import 'package:yellow_pass/presentation/splash_screen/binding/splash_screen_binding.dart';
import 'package:yellow_pass/presentation/splash_screen/splash_screen.dart';
import 'package:yellow_pass/presentation/welcome_screen/welcome_screen.dart';

import '../presentation/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String splashScreenRoute = '/splash_screen';
  static const String welcomeScreenRoute = '/welcome_screen';
  static const String loginScreenRoute = '/login_screen';
  static const String registerScreenRoute = '/register_screen';
  static const String dashboardScreenRoute = '/dashboard_screen';
  static const String homeScreenRoute = '/home_screen';
  static const String notificationScreenRoute = '/notification_screen';
  static const String profileScreenRoute = '/profile_screen';
  static const String networkScreenRoute = '/network_screen';
  static const String onBoardingRoute = '/onBoarding_screen';

  static List<GetPage> pages = [
    GetPage(
        name: splashScreenRoute,
        page: () => const SplashScreen(),
        bindings: [
          SplashScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: welcomeScreenRoute,
        page: () => const WelComeScreen(),
        bindings: [
          WelComeScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: loginScreenRoute,
        page: () => const LoginScreen(),
        bindings: [
          LoginScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: registerScreenRoute,
        page: () => const RegisterScreen(),
        bindings: [
          RegisterScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: dashboardScreenRoute,
        page: () => const DashboardScreen(),
        bindings: [
          DashboardScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: homeScreenRoute,
        page: () => const HomeScreen(),
        bindings: [
          HomeScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: notificationScreenRoute,
        page: () => const NotificationScreen(),
        bindings: [
          NotificationScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: profileScreenRoute,
        page: () => const ProfileScreen(),
        bindings: [
          ProfileScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: networkScreenRoute,
        page: () => const NetworkScreen(),
        bindings: [
          NetworkScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: onBoardingRoute,
        page: () =>  OnboardingScreen(),
        bindings: [
          OnboardingScreenBinding(),
        ],
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300)),
  ];
}
