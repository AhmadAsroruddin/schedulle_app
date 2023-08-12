import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedulle_app/presentation/bloc/Auth_bloc.dart';
import 'package:schedulle_app/presentation/bloc/request_bloc.dart';
import 'package:schedulle_app/presentation/bloc/task_bloc.dart';
import 'package:schedulle_app/presentation/page/auth/register_page.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';

import './locator.dart' as di;
import 'presentation/routes/router_delegate.dart';

Future<void> main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBO8hj-VyPpbceu46x8tU0fLrb-7KqK1No",
        appId: "1:996618749505:android:80dbf4dd77c27722b428c0",
        messagingSenderId: "996618749505",
        projectId: "schedule-7edfd"),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;
  @override
  void initState() {
    super.initState();
    myRouterDelegate = MyRouterDelegate();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<AuthCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TaskCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RequestCubit>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: lightBackgroundColor,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: null, // Atur null untuk menggunakan warna default
            ),
          ),
        ),
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
        routes: {RegisterPage.routeName: (context) => RegisterPage()},
      ),
    );
  }
}
