import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fooderlich_theme.dart';
import 'models/models.dart';
// TODO: Import app_router
import 'navigation/app_router.dart';


void main() {
  runApp(
    const Fooderlich(),
  );
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  _FooderlichState createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  // TODO: Create AppStateManager
  final _appStateManager = AppStateManager();

  // TODO: Define AppRouter
  late AppRouter _appRouter;


  // TODO: Initialize app router
  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        // TODO: Add AppStateManager ChangeNotifierProvider
        ChangeNotifierProvider(create: (context) => _appStateManager,),

      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp(
            theme: theme,
            title: 'Fooderlich',
            // TODO: Replace with Router widget
            home: Router(
              routerDelegate: _appRouter,
              // TODO: Add backButtonDispatcher
            ),

          );
        },
      ),
    );
  }
}
