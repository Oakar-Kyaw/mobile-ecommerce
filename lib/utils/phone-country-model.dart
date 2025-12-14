class PhoneCountry {
  final String name;
  final String code;
  final String flag;
  final String isoCode;

  PhoneCountry({
    required this.name,
    required this.code,
    required this.flag,
    required this.isoCode
  });

  String get display => "$flag $isoCode ($code)";
  String get short => "$flag $code";
}
