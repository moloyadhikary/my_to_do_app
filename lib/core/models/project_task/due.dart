import 'dart:convert';

import 'package:equatable/equatable.dart';

class Due extends Equatable {
  final String? date;
  final String? datetime;
  final bool? isRecurring;
  final String? lang;
  final String? string;

  const Due({
    this.date,
    this.datetime,
    this.isRecurring,
    this.lang,
    this.string,
  });

  factory Due.fromMap(Map<String, dynamic> data) => Due(
        date: data['date'] as String?,
        datetime: data['datetime'] as String?,
        isRecurring: data['is_recurring'] as bool?,
        lang: data['lang'] as String?,
        string: data['string'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'date': date,
        'datetime': datetime,
        'is_recurring': isRecurring,
        'lang': lang,
        'string': string,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Due].
  factory Due.fromJson(String data) {
    return Due.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Due] to a JSON string.
  String toJson() => json.encode(toMap());

  Due copyWith({
    String? date,
    String? datetime,
    bool? isRecurring,
    String? lang,
    String? string,
  }) {
    return Due(
      date: date ?? this.date,
      datetime: datetime ?? this.datetime,
      isRecurring: isRecurring ?? this.isRecurring,
      lang: lang ?? this.lang,
      string: string ?? this.string,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [date, datetime, isRecurring, lang, string];
}
