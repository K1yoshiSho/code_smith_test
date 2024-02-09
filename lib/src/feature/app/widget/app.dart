import 'package:base_starter/src/feature/app/widget/material_context.dart';
import 'package:base_starter/src/feature/initialization/model/dependencies.dart';
import 'package:base_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:base_starter/src/feature/settings/presentation/settings_scope.dart';
import 'package:flutter/material.dart';

/// {@template app}
/// [App] is an entry point to the application.
///
/// Scopes that don't depend on widgets returned by [MaterialApp]
/// ([Directionality], [MediaQuery], [Localizations]) should be placed here.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({required this.result, super.key});

  /// Running this function will result in attaching
  /// corresponding [RenderObject] to the root of the tree.
  void attach([VoidCallback? callback]) {
    callback?.call();
    runApp(this);
  }

  /// The initialization result from the `InitializationProcessor`
  /// which contains initialized dependencies.
  final InitializationResult result;

  @override
  Widget build(BuildContext context) => DependenciesScope(
        dependencies: result.dependencies,
        child: SettingsScope(
          settingsBloc: result.dependencies.settingsBloc,
          child: const MaterialContext(),
        ),
      );
}
