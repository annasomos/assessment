import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/i18n/i18n_provider.dart';
import 'package:users_app/presentation/theme/app_theme.dart';
import 'package:users_app/presentation/theme/scale.dart';
import 'package:users_app/screens/user_list_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(i18nProvider);
    Scale.setup(
      screenSize: MediaQuery.of(context).size,
      designSize: const Size(360, 640),
    );

    return AppTheme(brightness: MediaQuery.of(context).platformBrightness, child: Builder(builder: (context) {
      return MaterialApp(
      locale: locale,
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader:
              FileTranslationLoader(basePath: 'lib/i18n/locales'),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('hu'), Locale('en')],
      title: 'Flutter Demo',
      theme: AppTheme.of(context).theme,
      home: Builder(builder: (context) {
        ref.watch(i18nProvider.notifier).initializeAppContext(context);
        return const UserListScreen();
      }),
    );
    },));
  }
}
