import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'due.dart';

class Task extends Equatable {
  final dynamic assigneeId;
  final dynamic assignerId;
  final int? commentCount;
  final String? content;
  final DateTime? createdAt;
  final String? creatorId;
  final String? description;
  final Due? due;
  final dynamic duration;
  final String? id;
  final bool? isCompleted;
  final List<dynamic>? labels;
  final int? order;
  final dynamic parentId;
  final int? priority;
  final String? projectId;
  final String? sectionId;
  final String? url;

  const Task({
    this.assigneeId,
    this.assignerId,
    this.commentCount,
    this.content,
    this.createdAt,
    this.creatorId,
    this.description,
    this.due,
    this.duration,
    this.id,
    this.isCompleted,
    this.labels,
    this.order,
    this.parentId,
    this.priority,
    this.projectId,
    this.sectionId,
    this.url,
  });

  factory Task.fromMap(Map<String, dynamic> data) => Task(
        assigneeId: data['assignee_id'] as dynamic,
        assignerId: data['assigner_id'] as dynamic,
        commentCount: data['comment_count'] as int?,
        content: data['content'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        creatorId: data['creator_id'] as String?,
        description: data['description'] as String?,
        due: data['due'] == null
            ? null
            : Due.fromMap(data['due'] as Map<String, dynamic>),
        duration: data['duration'] as dynamic,
        id: data['id'] as String?,
        isCompleted: data['is_completed'] as bool?,
        labels: data['labels'] as List<dynamic>?,
        order: data['order'] as int?,
        parentId: data['parent_id'] as dynamic,
        priority: data['priority'] as int?,
        projectId: data['project_id'] as String?,
        sectionId: data['section_id'] as String?,
        url: data['url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'assignee_id': assigneeId,
        'assigner_id': assignerId,
        'comment_count': commentCount,
        'content': content,
        'created_at': createdAt?.toIso8601String(),
        'creator_id': creatorId,
        'description': description,
        'due': due?.toMap(),
        'duration': duration,
        'id': id,
        'is_completed': isCompleted,
        'labels': labels,
        'order': order,
        'parent_id': parentId,
        'priority': priority,
        'project_id': projectId,
        'section_id': sectionId,
        'url': url,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Task].
  factory Task.fromJson(String data) {
    return Task.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Task] to a JSON string.
  String toJson() => json.encode(toMap());

  Task copyWith({
    dynamic assigneeId,
    dynamic assignerId,
    int? commentCount,
    String? content,
    DateTime? createdAt,
    String? creatorId,
    String? description,
    Due? due,
    dynamic duration,
    String? id,
    bool? isCompleted,
    List<String>? labels,
    int? order,
    dynamic parentId,
    int? priority,
    String? projectId,
    String? sectionId,
    String? url,
  }) {
    return Task(
      assigneeId: assigneeId ?? this.assigneeId,
      assignerId: assignerId ?? this.assignerId,
      commentCount: commentCount ?? this.commentCount,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      creatorId: creatorId ?? this.creatorId,
      description: description ?? this.description,
      due: due ?? this.due,
      duration: duration ?? this.duration,
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      labels: labels ?? this.labels,
      order: order ?? this.order,
      parentId: parentId ?? this.parentId,
      priority: priority ?? this.priority,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      url: url ?? this.url,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      assigneeId,
      assignerId,
      commentCount,
      content,
      createdAt,
      creatorId,
      description,
      due,
      duration,
      id,
      isCompleted,
      labels,
      order,
      parentId,
      priority,
      projectId,
      sectionId,
      url,
    ];
  }
}
