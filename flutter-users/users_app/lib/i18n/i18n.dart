import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:users_app/i18n/i18n_provider.dart';

final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [
  FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      basePath: 'lib/i18n/locales',
      decodeStrategies: [
        JsonDecodeStrategy(),
      ],
    ),
    missingTranslationHandler: (key, locale) {
      debugPrint("Missing Key: $key, languageCode: ${locale!.languageCode}");
    },
  ),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate
];

const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('hu'),
];

class I18n extends HookConsumerWidget {
  const I18n({Key? key, required this.builder}) : super(key: key);

  final Widget Function(
    BuildContext context,
    Locale? locale,
    Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    List<Locale> supportedLocales,
    void Function(BuildContext context) initializeAppContext,
  ) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void initializeAppContext(BuildContext appContext) {
      ref.read(i18nProvider.notifier).initializeAppContext(appContext);
    }

    final locale = ref.watch(i18nProvider);

    return builder(
      context,
      locale,
      localizationsDelegates,
      supportedLocales,
      initializeAppContext,
    );
  }
}

extension I18nContextExtension on BuildContext {
  String tr(String key, {int? count, Map<String, String>? params}) {
    if (count != null) {
      return FlutterI18n.plural(this, key, count);
    }
    return FlutterI18n.translate(this, key, translationParams: params);
  }
}