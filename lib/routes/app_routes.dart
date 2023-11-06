import 'package:videos/controller/navigation_cubit.dart';
import 'package:videos/screens//home_details_screen.dart';
import 'package:videos/screens/home_screen.dart';
import 'package:videos/screens/main_screen.dart';
import 'package:videos/screens/profile_details_screen.dart';
import 'package:videos/screens/profile_screen.dart';
import 'package:videos/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';
import '../../screens/not_found_page.dart';

class AppRouter {

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.homeNamedPage,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => NavigationCubit(),
            child: MainScreen(screen: child),
          );
        },
        routes: [
          GoRoute(
            path: Routes.homeNamedPage,
            pageBuilder: (context, state) =>
            const NoTransitionPage(
              child: HomeScreen(),
            ),
            routes: [
              GoRoute(
                path: Routes.homeDetailsNamedPage,
                builder: (context, state) => HomeDetailsScreen(
                    id: state.pathParameters['id']
                ),
              ),
            ],
          ),
          GoRoute(
            path: Routes.profileNamedPage,
            pageBuilder: (context, state) =>
            const NoTransitionPage(
              child: ProfileScreen(),
            ),
            routes: [
              GoRoute(
                path: Routes.profileDetailsNamedPage,
                builder: (context, state) => const ProfileDetailsScreen(),
              ),
            ],
          ),
          GoRoute(
            path: Routes.settingsNamedPage,
            pageBuilder: (context, state) =>
            const NoTransitionPage(
              child: SettingScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),

  );

  static GoRouter get router => _router;
}