import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'comment.dart';

class TaskComments extends Equatable {
  final List<Comment>? comments;

  const TaskComments({this.comments});

  factory TaskComments.fromMap(Map<String, dynamic> data) => TaskComments(
        comments: (data['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'comments': comments?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TaskComments].
  factory TaskComments.fromJson(String data) {
    return TaskComments.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TaskComments] to a JSON string.
  String toJson() => json.encode(toMap());

  TaskComments copyWith({
    List<Comment>? comments,
  }) {
    return TaskComments(
      comments: comments ?? this.comments,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [comments];
}
