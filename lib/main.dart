import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_poupular_actors/router/custom_router.gr.dart';
import 'package:my_poupular_actors/theme/app_theme.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_test/flutter_test.dart';
import 'helpers/app_shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // custom initial helpers
  await AppSharedPrefs.ensureInit();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter =
      AppRouter(); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 736),
        builder: (BuildContext context, Widget? child) {
          return OverlaySupport(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routeInformationParser: _appRouter.defaultRouteParser(),
              routerDelegate: AutoRouterDelegate(_appRouter),
              builder: (context, child) {
                return AppTheme(navigator: child!);
              },
            ),
          );
        });
  }
}
