class FieldValidator<T> {
  FieldValidator({
    required this.validator,
  });
  FieldValidator.decimalNumber() : validator = isDecimalNumber;
  FieldValidator.realNumber() : validator = isRealNumber;

  final bool Function(T value) validator;
  bool isValid(dynamic value) => validator(value as T);
}

bool isDecimalNumber(dynamic value) {
  final parsedNumber = int.tryParse(value.toString());
  return parsedNumber != null;
}

bool isRealNumber(dynamic value) {
  final parsedNumber = double.tryParse(value.toString());
  return parsedNumber != null;
}

class PatternValidator extends FieldValidator<String> {
  PatternValidator({required String pattern, bool unicode = false})
      : super(validator: (value) {
          return RegExp(pattern, unicode: unicode).hasMatch(value);
        });

  factory PatternValidator.password() => PatternValidator(
        unicode: true,
        pattern: r'^(?=.{8,32}$)(?=.*?\p{Ll})(?=.*?\p{Lu})(?=.*?\d).*$',
      );
  factory PatternValidator.simplePassword() => PatternValidator(pattern: r'^(?=.{8,}$).*$');

  factory PatternValidator.email() => PatternValidator(
        pattern:
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      );
}