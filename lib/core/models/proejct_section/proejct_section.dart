import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'section_datum.dart';

class ProejctSection extends Equatable {
  final List<SectionDatum>? sectionData;

  const ProejctSection({this.sectionData});

  factory ProejctSection.fromMap(Map<String, dynamic> data) {
    return ProejctSection(
      sectionData: (data['section_data'] as List<dynamic>?)
          ?.map((e) => SectionDatum.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'section_data': sectionData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProejctSection].
  factory ProejctSection.fromJson(String data) {
    return ProejctSection.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProejctSection] to a JSON string.
  String toJson() => json.encode(toMap());

  ProejctSection copyWith({
    List<SectionDatum>? sectionData,
  }) {
    return ProejctSection(
      sectionData: sectionData ?? this.sectionData,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [sectionData];
}
