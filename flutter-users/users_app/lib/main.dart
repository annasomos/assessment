import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/i18n/i18n_provider.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Builder(builder: (context) {
        ref.watch(i18nProvider.notifier).initializeAppContext(context);
        return const UserListScreen();
      }),
    );
  }
}
