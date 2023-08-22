import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/presentation/routing/app_auto_router.gr.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:users_app/presentation/theme/scale.dart';
import 'package:users_app/i18n/i18n.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Scale.setup(
      screenSize: MediaQuery.of(context).size,
      designSize: const Size(360, 640),
    );

    final appRouter = useState(AppAutoRouter()).value;

    return I18n(
      builder: (context, locale, localizationsDelegates, supportedLocales,
          initializeAppContext) {
        return AppTheme(
          brightness: Brightness.dark,
          child: MaterialApp.router(
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
            title: 'Dina Users',
            locale: locale,
            localizationsDelegates: localizationsDelegates,
            debugShowCheckedModeBanner: false,
            supportedLocales: supportedLocales,
            builder: (context, navigator) {
              initializeAppContext(context);
              return navigator!;
            },
          ),
        );
      },
    );
  }
}
      
