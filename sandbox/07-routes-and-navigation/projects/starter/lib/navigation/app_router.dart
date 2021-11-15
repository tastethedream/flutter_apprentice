import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

// 1
class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  // 2
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // 3
  final AppStateManager appStateManager;
  // 4
  final GroceryManager groceryManager;
  // 5
  final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  })
      : navigatorKey = GlobalKey<NavigatorState>() {
    // TODO: Add Listeners
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);

  }

  // TODO: Dispose listeners
  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }


  // 6
  @override
  Widget build(BuildContext context) {
    // 7
    return Navigator(
      // 8
      key: navigatorKey,
      // TODO: Add onPopPage
      onPopPage: _handlePopPage,

      // 9
      pages: [
        // TODO: Add SplashScreen
        if (!appStateManager.isInitialized) SplashScreen.page(),

        // TODO: Add LoginScreen
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),

        // TODO: Add OnboardingScreen
        if (appStateManager.isLoggedIn &&
            !appStateManager.isOnboardingComplete)
          OnboardingScreen.page(),

        // TODO: Add Home
        if (appStateManager.isOnboardingComplete)
          Home.page(appStateManager.getSelectedTab),

        // TODO: Create new item
        // 1
        if (groceryManager.isCreatingNewItem)
// 2
          GroceryItemScreen.page(
            onCreate: (item) {
              // 3
              groceryManager.addItem(item);
            }, onUpdate: (item, index) {
            // 4 No update
          },
          ),

        // TODO: Select GroceryItemScreen
        // 1
        if (groceryManager.selectedIndex != -1)
        // 2
          GroceryItemScreen.page(
              item: groceryManager.selectedGroceryItem,
              index: groceryManager.selectedIndex,
              onUpdate: (item, index) {
                // 3
                groceryManager.updateItem(item, index);
              },
              onCreate: (_) {
                // 4 No create
              }
          ),

        // TODO: Add Profile Screen
        if (profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),

        // TODO: Add WebView Screen
      ],
    );
  }

  // TODO: Add _handlePopPage
  bool _handlePopPage(
      // 1
      Route<dynamic> route,
      // 2
      result) {
    // 3
    if (!route.didPop(result)) {
      // 4
      return false;
    }

    // 5
    // TODO: Handle Onboarding and splash
    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }

    // TODO: Handle state when user closes grocery item screen
    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }

    // TODO: Handle state when user closes profile screen
    // TODO: Handle state when user closes WebView screen
    // 6
    return true;
  }


  // 10
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
