import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schedulle_app/presentation/page/add_friends_page.dart';
import 'package:schedulle_app/presentation/page/add_task.dart';
import 'package:schedulle_app/presentation/page/auth/login_page.dart';
import 'package:schedulle_app/presentation/page/auth/register_page.dart';
import 'package:schedulle_app/presentation/page/friends_page.dart';
import 'package:schedulle_app/presentation/page/home_page.dart';
import 'package:schedulle_app/presentation/page/notification_page.dart';
import 'package:schedulle_app/presentation/page/schedule_page.dart';
import 'package:schedulle_app/presentation/page/splash_page.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  bool? isLoggedIn;
  List<Page> historyStack = [];
  bool? isRegister;
  User? userData;

  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    print("fired init");
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    userData = user;
    Future.delayed(const Duration(seconds: 1), () {
      if (user != null) {
        isLoggedIn = true;
        notifyListeners();
      } else {
        isLoggedIn = false;
        notifyListeners();
      }
    });
  }

  Future<void> getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user = auth.currentUser;
    userData = user;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashScreen;
    } else if (isLoggedIn == true) {
      historyStack = _loggedOutStack;
    } else {
      historyStack = _loggedInStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/registerPage') {
          return MaterialPageRoute(
              builder: (_) => RegisterPage(), settings: settings);
        }

        if (settings.name == SchedulePage.routeName) {
          return MaterialPageRoute(
              builder: (_) => SchedulePage(
                    user: userData,
                  ),
              settings: settings);
        }

        if (settings.name == AddTask.routeName) {
          return MaterialPageRoute(
              builder: (_) => const AddTask(), settings: settings);
        }

        if (settings.name == FriendsPage.routeName) {
          return MaterialPageRoute(
              builder: (_) => FriendsPage(), settings: settings);
        }

        if (settings.name == AddFriendsPage.routeName) {
          return MaterialPageRoute(builder: (_) => const AddFriendsPage());
        }

        if (settings.name == NotificationPage.routeName) {
          return MaterialPageRoute(
              builder: (_) => NotificationPage(
                    uid: userData!.uid.toString(),
                  ));
        }
        return null;
      },
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* Do Nothing */
  }
  void logout() async {
    isLoggedIn = false;
    userData = null;
    notifyListeners();
  }

  Future<void> login() async {
    isLoggedIn = true;
    await getUserData();
    notifyListeners();
  }

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey('LoginPage'),
          child: LoginPage(),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey('RegisterPage'),
            child: RegisterPage(),
          ),
      ];
  List<Page> get _loggedOutStack => [
        MaterialPage(
            key: const ValueKey('HomePage'),
            child: HomePage(
              user: userData,
            ))
      ];

  List<Page> get _splashScreen => [
        const MaterialPage(key: ValueKey('loadingPage'), child: SplashPage()),
      ];
}
