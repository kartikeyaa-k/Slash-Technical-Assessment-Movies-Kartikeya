import 'package:flutter/material.dart';
import 'package:slash_assignment_movies/src/presentation/views/login_view.dart';
import 'package:slash_assignment_movies/src/presentation/views/movies_view.dart';
import 'package:slash_assignment_movies/src/presentation/views/splash_view.dart';
import 'package:slash_assignment_movies/src/presentation/views/welcome_view.dart';

class AppRoutes {
  static String initialRoute() {
    return '/';
  }

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SplashView());

      case 'welcome':
        return _materialRoute(const WelcomeView());

      case 'login':
        return _materialRoute(const LoginView());

      case 'movie':
        return _materialRoute(const MoviesView());

      default:
        return _materialRoute(const LoginView());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
