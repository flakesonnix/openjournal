import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openjournal/ui/main_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/search/add_ingestion_search_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/interactions/check_interactions_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/route/choose_route_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/dose/choose_dose_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/experience_detail_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/edit/edit_experience_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/editingestion/edit_ingestion_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/timednote/timed_note_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/rating/add_rating_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/calendar/calendar_screen.dart';
import 'package:openjournal/ui/tabs/safer/volumetric_dosing_screen.dart';
import 'package:openjournal/ui/tabs/safer/safer_stimulants_screen.dart';
import 'package:openjournal/ui/tabs/safer/safer_hallucinogens_screen.dart';
import 'package:openjournal/ui/tabs/safer/safer_sniffing_screen.dart';
import 'package:openjournal/ui/tabs/safer/reagent_testing_screen.dart';
import 'package:openjournal/ui/tabs/safer/drug_testing_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/time/finish_ingestion_screen.dart';
import 'package:openjournal/ui/tabs/search/search_screen.dart';
import 'package:openjournal/ui/tabs/search/substance_detail_screen.dart';
import 'package:openjournal/ui/tabs/search/custom/add_custom_substance_screen.dart';
import 'package:openjournal/ui/tabs/settings/customunits/add_custom_unit_screen.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/dose/customunit/choose_dose_custom_unit_screen.dart';
import 'package:openjournal/models/substance/administration_route.dart';

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
      path: '/experience/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id']!);
        if (id == null) {
          return const MainScreen();
        }
        return ExperienceDetailScreen(experienceId: id);
      },
    ),
    GoRoute(
      path: '/edit-experience/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return EditExperienceScreen(experienceId: id);
      },
    ),
    GoRoute(
      path: '/add-rating/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return AddRatingScreen(experienceId: id);
      },
    ),
    GoRoute(
      path: '/edit-ingestion/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return EditIngestionScreen(ingestionId: id);
      },
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => const CalendarScreen(),
    ),
    GoRoute(
      path: '/volumetric-dosing',
      builder: (context, state) => const VolumetricDosingScreen(),
    ),
    GoRoute(
      path: '/safer-stimulants',
      builder: (context, state) => const SaferStimulantsScreen(),
    ),
    GoRoute(
      path: '/safer-hallucinogens',
      builder: (context, state) => const SaferHallucinogensScreen(),
    ),
    GoRoute(
      path: '/safer-sniffing',
      builder: (context, state) => const SaferSniffingScreen(),
    ),
    GoRoute(
      path: '/reagent-testing',
      builder: (context, state) => const ReagentTestingScreen(),
    ),
    GoRoute(
      path: '/drug-testing',
      builder: (context, state) => const DrugTestingScreen(),
    ),
    GoRoute(
      path: '/substance/:name',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        return SubstanceDetailScreen(substanceName: name);
      },
    ),
    GoRoute(
      path: '/add-custom-substance',
      builder: (context, state) {
        final name = state.uri.queryParameters['name'];
        return AddCustomSubstanceScreen(initialName: name);
      },
    ),
    GoRoute(
      path: '/add-timed-note/:experienceId',
      builder: (context, state) {
        final expId = int.parse(state.pathParameters['experienceId']!);
        return TimedNoteScreen(experienceId: expId);
      },
    ),
    GoRoute(
      path: '/edit-timed-note/:noteId/:experienceId',
      builder: (context, state) {
        final noteId = int.parse(state.pathParameters['noteId']!);
        final expId = int.parse(state.pathParameters['experienceId']!);
        return TimedNoteScreen(noteId: noteId, experienceId: expId);
      },
    ),
    GoRoute(
      path: '/add-ingestion',
      builder: (context, state) {
        final expId = int.tryParse(state.uri.queryParameters['experienceId'] ?? "");
        return AddIngestionSearchScreen(experienceId: expId);
      },
      routes: [
        GoRoute(
          path: 'interactions/:substanceName',
          builder: (context, state) {
            final substanceName = state.pathParameters['substanceName']!;
            final expId = int.tryParse(state.uri.queryParameters['experienceId'] ?? "");
            return CheckInteractionsScreen(
              substanceName: substanceName,
              onNext: () => context.go('/add-ingestion/route/$substanceName?experienceId=${expId ?? 'null'}'),
            );
          },
        ),
        GoRoute(
          path: 'route/:substanceName',
          builder: (context, state) {
            final substanceName = state.pathParameters['substanceName']!;
            final expId = int.tryParse(state.uri.queryParameters['experienceId'] ?? "");
            return ChooseRouteScreen(substanceName: substanceName, experienceId: expId);
          },
        ),
        GoRoute(
          path: 'dose/:substanceName/:route',
          builder: (context, state) {
            final substanceName = state.pathParameters['substanceName']!;
            final route = state.pathParameters['route']!;
            final expId = int.tryParse(state.uri.queryParameters['experienceId'] ?? "");
            return ChooseDoseScreen(substanceName: substanceName, route: route, experienceId: expId);
          },
        ),
        GoRoute(
          path: 'add-custom-unit/:substanceName/:route',
          builder: (context, state) {
            final substanceName = state.pathParameters['substanceName']!;
            final routeName = state.pathParameters['route']!;
            return AddCustomUnitScreen(substanceName: substanceName, routeName: routeName);
          },
        ),
        GoRoute(
          path: 'choose-dose-custom-unit/:unitId',
          builder: (context, state) {
            final unitId = int.parse(state.pathParameters['unitId']!);
            final expId = int.tryParse(state.uri.queryParameters['experienceId'] ?? "");
            return ChooseDoseCustomUnitScreen(customUnitId: unitId, experienceId: expId);
          },
        ),
        GoRoute(
          path: 'finish/:substanceName/:route/:dose/:units/:isEstimate/:customUnitId',
          builder: (context, state) {
            final sub = state.pathParameters['substanceName']!;
            final route = AdministrationRoute.values.firstWhere((r) => r.name == state.pathParameters['route']!);
            final dose = double.tryParse(state.pathParameters['dose']!);
            final units = state.pathParameters['units'] == 'null' ? null : state.pathParameters['units'];
            final isEstimate = state.pathParameters['isEstimate'] == 'true';
            final customUnitId = int.tryParse(state.pathParameters['customUnitId']!);
            final expId = int.tryParse(state.uri.queryParameters['experienceId'] ?? "");

            return FinishIngestionScreen(
              substanceName: sub,
              route: route,
              dose: dose,
              units: units,
              isEstimate: isEstimate,
              customUnitId: customUnitId,
              experienceId: expId,
            );
          },
        ),
      ],
    ),
  ],
);
