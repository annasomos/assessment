import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/i18n/i18n_provider.dart';
import 'package:collection/collection.dart';

const fallbackLocale = Locale("en");

abstract class TranslatedValue {
  factory TranslatedValue.value(String value) => StaticTranslatedValue._(value);

  factory TranslatedValue.key(String key, [String? baseKey, String? keySeparator = '.', Map<String, String>? params]) {
    return TranslatedKeyValue._(key: key, baseKey: baseKey, keySeparator: keySeparator, params: params);
  }

  factory TranslatedValue.map(Map<String, String> map) => TranslatedMapValue._(map);

  String getValue(WidgetRef ref);
  String getRaw();
  dynamic toJson();

  @override
  bool operator ==(Object other) =>
      other is TranslatedValue && other.runtimeType == runtimeType && other.getRaw() == getRaw();

  @override
  int get hashCode => getRaw().hashCode;
}

class TranslatedKeyValue implements TranslatedValue {
  const TranslatedKeyValue._({
    required this.key,
    this.baseKey,
    this.keySeparator,
    this.params,
  });

  final String key;
  final String? baseKey;
  final String? keySeparator;
  final Map<String, String>? params;

  @override
  String getValue(WidgetRef ref) {
    final translationKey = getRaw();
    return ref.watch(i18nProvider.notifier).tr(translationKey);
  }

  @override
  String getRaw() {
    if (baseKey == null) {
      return key;
    }

    return '$baseKey$keySeparator$key';
  }

  static TranslatedValue? fromJson(
    String? value, [
    String? baseKey,
    String? keySeparator = '.',
  ]) {
    if (value == null) {
      return null;
    }

    return TranslatedKeyValue._(
      key: value,
      baseKey: baseKey,
      keySeparator: keySeparator,
    );
  }

  @override
  String toJson() => key;

  @override
  bool operator ==(Object other) =>
      other is TranslatedValue && other.runtimeType == runtimeType && other.getRaw() == getRaw();

  @override
  int get hashCode => getRaw().hashCode;
}

class TranslatedMapValue extends DelegatingMap<String, String?> implements TranslatedValue {
  TranslatedMapValue._(Map<String, String?> map) : super(map);

  @override
  String getValue(WidgetRef ref) {
    final locale = ref.watch(i18nProvider.notifier).getCurrentLocale();

    final languageCode = locale.languageCode;
    return this[languageCode] ?? this[fallbackLocale.languageCode] ?? '"$languageCode" language code is missing';
  }

  @override
  String getRaw() {
    final entryList = toJson().entries.toList();
    entryList.sort((a, b) => a.key.compareTo(b.key));

    final sortedMap = Map<String, dynamic>.fromEntries(entryList);
    return jsonEncode(sortedMap);
  }

  static TranslatedValue fromJson(Map<String, String?> json) {
    return TranslatedMapValue._(json);
  }

  @override
  Map<String, dynamic> toJson() => this;

  @override
  bool operator ==(Object other) =>
      other is TranslatedValue && other.runtimeType == runtimeType && other.getRaw() == getRaw();

  @override
  int get hashCode => getRaw().hashCode;
}

class StaticTranslatedValue implements TranslatedValue {
  const StaticTranslatedValue._(this.value);

  final String value;

  @override
  String getValue([WidgetRef? ref]) => value;

  @override
  String getRaw() => value;

  @override
  String toJson() => value;

  @override
  bool operator ==(Object other) =>
      other is TranslatedValue && other.runtimeType == runtimeType && other.getRaw() == getRaw();

  @override
  int get hashCode => getRaw().hashCode;
}

List<TranslatedValue>? listFromTranslationKey(List<String>? list, String baseKey) {
  if (list == null) {
    return null;
  }

  return list.map((value) => TranslatedValue.key(value, baseKey)).toList();
}

List<String>? listToTranslationKey(List<TranslatedValue>? list, String baseKey) {
  if (list == null) {
    return null;
  }

  return list.map((value) => (value as TranslatedKeyValue).toJson()).toList();
}