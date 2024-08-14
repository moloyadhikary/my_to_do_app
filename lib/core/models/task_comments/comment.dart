import 'dart:convert';

import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final dynamic attachment;
  final String? content;
  final String? id;
  final DateTime? postedAt;
  final dynamic projectId;
  final String? taskId;

  const Comment({
    this.attachment,
    this.content,
    this.id,
    this.postedAt,
    this.projectId,
    this.taskId,
  });

  factory Comment.fromMap(Map<String, dynamic> data) => Comment(
        attachment: data['attachment'] as dynamic,
        content: data['content'] as String?,
        id: data['id'] as String?,
        postedAt: data['posted_at'] == null
            ? null
            : DateTime.parse(data['posted_at'] as String),
        projectId: data['project_id'] as dynamic,
        taskId: data['task_id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'attachment': attachment,
        'content': content,
        'id': id,
        'posted_at': postedAt?.toIso8601String(),
        'project_id': projectId,
        'task_id': taskId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Comment].
  factory Comment.fromJson(String data) {
    return Comment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Comment] to a JSON string.
  String toJson() => json.encode(toMap());

  Comment copyWith({
    dynamic attachment,
    String? content,
    String? id,
    DateTime? postedAt,
    dynamic projectId,
    String? taskId,
  }) {
    return Comment(
      attachment: attachment ?? this.attachment,
      content: content ?? this.content,
      id: id ?? this.id,
      postedAt: postedAt ?? this.postedAt,
      projectId: projectId ?? this.projectId,
      taskId: taskId ?? this.taskId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      attachment,
      content,
      id,
      postedAt,
      projectId,
      taskId,
    ];
  }
}
