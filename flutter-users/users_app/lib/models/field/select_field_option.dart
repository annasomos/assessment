import 'package:users_app/utils/translated_value.dart';

class SelectFieldOption {
  SelectFieldOption({
    required this.id,
    required this.label,
    this.disabled = false,
    this.value,
  });

  final String id;
  final TranslatedValue label;
  final bool disabled;
  final dynamic value;

  @override
  bool operator ==(Object other) =>
      other is SelectFieldOption && other.runtimeType == runtimeType && other.id == id && other.label == label;

  @override
  int get hashCode => id.hashCode;
}