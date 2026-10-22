import 'package:accesibility_together/core/routes/routes_constants.dart';
import 'package:accesibility_together/features/todo_screen/presentation/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutesConstants.todoScreen,
    navigatorKey: navigatorKey,
    routes: [
      // --  Without passing params
      GoRoute(path: RoutesConstants.todoScreen, name: RoutesConstants.todoScreen, builder: (context, state) => TodoScreen()),


      // GoRoute(
      //   path: RoutesConstants.myEventsScreen,
      //   name: RoutesConstants.myEventsScreen,
      //   builder: (context, state) {
      //     final initialTab = state.extra is MyEventsTab ? state.extra as MyEventsTab : MyEventsTab.upcoming;
      //     final args = state.extra as Map<String, dynamic>?;
      //     final eventId = args?['eventId'] ?? "";
      //     return MyEventsScreen(initialTab: initialTab, eventId: eventId);
      //   },
      // ),
    ],
  );
});
