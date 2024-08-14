import 'dart:convert';

import 'package:equatable/equatable.dart';

class SectionDatum extends Equatable {
  final String? id;
  final String? name;
  final int? order;
  final String? projectId;

  const SectionDatum({this.id, this.name, this.order, this.projectId});

  factory SectionDatum.fromMap(Map<String, dynamic> data) => SectionDatum(
        id: data['id'] as String?,
        name: data['name'] as String?,
        order: data['order'] as int?,
        projectId: data['project_id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'order': order,
        'project_id': projectId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SectionDatum].
  factory SectionDatum.fromJson(String data) {
    return SectionDatum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SectionDatum] to a JSON string.
  String toJson() => json.encode(toMap());

  SectionDatum copyWith({
    String? id,
    String? name,
    int? order,
    String? projectId,
  }) {
    return SectionDatum(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      projectId: projectId ?? this.projectId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, order, projectId];
}
