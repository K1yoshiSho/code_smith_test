import 'dart:async';

import 'package:base_starter/src/core/utils/talker_logger.dart';
import 'package:base_starter/src/feature/app/widget/app.dart';
import 'package:base_starter/src/feature/initialization/logic/initialization_processor.dart';
import 'package:base_starter/src/feature/initialization/logic/initialization_steps.dart';
import 'package:base_starter/src/feature/initialization/model/initialization_hook.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_native_splash/flutter_native_splash.dart';

/// {@template app_runner}
/// A class which is responsible for initialization and running the app.
/// {@endtemplate}
final class AppRunner
    with
        InitializationSteps,
        InitializationProcessor,
        InitializationFactoryImpl {
  /// Start the initialization and in case of success run application
  Future<void> initializeAndRun(InitializationHook hook) async {
    final binding = WidgetsFlutterBinding.ensureInitialized()
      ..deferFirstFrame();

    // Preserve splash screen
    FlutterNativeSplash.preserve(widgetsBinding: binding);

    // Override logging
    await initHandling();

    // Setup bloc observer and transformer
    Bloc.transformer = bloc_concurrency.sequential();
    Future<void> initializeAndRun(InitializationHook hook) async {
      try {
        final result = await processInitialization(
          steps: initializationSteps,
          hook: hook,
          factory: this,
        );

        FlutterNativeSplash.remove();
        runApp(App(result: result));
      } catch (e) {
        rethrow;
      } finally {
        binding.allowFirstFrame();
      }
    }

    await initializeAndRun(hook);
  }
}
