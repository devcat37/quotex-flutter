import 'package:flutter/material.dart';
import 'package:quotex/internal/application.dart';
import 'package:quotex/internal/services/helpers.dart';
import 'package:quotex/internal/services/service_locator.dart';
import 'package:quotex/internal/services/settings.dart';
import 'package:quotex/internal/states/bottom_app_bar_state/bottom_app_bar_state.dart';
import 'package:quotex/internal/states/generate_data_state/generate_data_state.dart';
import 'package:quotex/internal/states/signals_screen_state/signals_screen_state.dart';
import 'package:quotex/internal/states/subscription_state/subscription_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Settings.
  final settings = Settings();
  await settings.initFirebase();
  await settings.initStorage();
  await rateMyApp.init();

  service.registerSingleton(settings);

  // States.
  service.registerLazySingleton<SignalsScreenState>(() => SignalsScreenState());
  service.registerLazySingleton<BottomAppBarState>(() => BottomAppBarState());
  service.registerLazySingleton<SubscriptionState>(() => SubscriptionState());
  service.registerLazySingleton<GenerateDataState>(() => GenerateDataState());

  runApp(const Application());
}
