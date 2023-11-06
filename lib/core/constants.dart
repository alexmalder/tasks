import 'package:videos/screens/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes{
  static const root = '/';
  static const homeNamedPage = '/home';
  static const homeDetailsNamedPage = ':id';
  static const profileNamedPage = '/profile';
  static const profileDetailsNamedPage = 'details';
  static const settingsNamedPage = '/settings';
  static const signInPage = '/sign-in';
  static const info = '/info';
  //static profileNamedPage([String? name]) => '/${name ?? ':profile'}';
  static Widget errorWidget(BuildContext context, GoRouterState state) => const NotFoundScreen();
}