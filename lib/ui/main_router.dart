import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openjournal/ui/main_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/search/add_ingestion_search_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/route/choose_route_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/dose/choose_dose_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/add-ingestion',
      builder: (context, state) => const AddIngestionSearchScreen(),
      routes: [
        GoRoute(
          path: 'route/:substanceName',
          builder: (context, state) {
            final substanceName = state.pathParameters['substanceName']!;
            return ChooseRouteScreen(substanceName: substanceName);
          },
        ),
        GoRoute(
          path: 'dose/:substanceName/:route',
          builder: (context, state) {
            final substanceName = state.pathParameters['substanceName']!;
            final route = state.pathParameters['route']!;
            return ChooseDoseScreen(substanceName: substanceName, route: route);
          },
        ),
      ],
    ),
  ],
);
