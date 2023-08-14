import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final i18nProvider = AutoDisposeNotifierProvider<I18nProvider, Locale?>(I18nProvider.new);

class I18nProvider extends AutoDisposeNotifier<Locale?> {
  @override
  Locale? build({Locale? locale}) => locale;

  BuildContext? context;

  Locale get platformLocale => Locale(Platform.localeName.substring(0, 2));

  // ignore: use_setters_to_change_properties
  void initializeAppContext(BuildContext context) {
    this.context = context;
  }

  Future setLocale(Locale? locale) async {
    assert(context != null, "context is not set in I18nProvider");
    await FlutterI18n.refresh(context!, locale);
    state = locale;
  }

  Locale getCurrentLocale() {
    assert(context != null, "context is not set in I18nProvider");
    return FlutterI18n.currentLocale(context!) ?? const Locale('en');
  }

  String tr(String key, {int? count, Map<String, String>? params}) {
    return context?.tr(key, count: count, params: params) ??
        "context is not set in I18nProvider, so cannot retrieve translation for $key";
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