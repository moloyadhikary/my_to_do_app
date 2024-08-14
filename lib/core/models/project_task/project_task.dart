import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'task.dart';

class ProjectTask extends Equatable {
  final List<Task>? tasks;

  const ProjectTask({this.tasks});

  factory ProjectTask.fromMap(Map<String, dynamic> data) => ProjectTask(
        tasks: (data['tasks'] as List<dynamic>?)
            ?.map((e) => Task.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'tasks': tasks?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProjectTask].
  factory ProjectTask.fromJson(String data) {
    return ProjectTask.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProjectTask] to a JSON string.
  String toJson() => json.encode(toMap());

  ProjectTask copyWith({
    List<Task>? tasks,
  }) {
    return ProjectTask(
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [tasks];
}
