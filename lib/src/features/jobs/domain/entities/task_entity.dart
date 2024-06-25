import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String name;
  final DateTime? callDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? comments;
  final int progress;
  final TaskStatus status;
  final TaskStage stage;
  final int? parentTask;
  final Contact? supplier;
  final List<dynamic>? attachments;
  final int job;
  final int order;

  const Task({
    this.id,
    required this.name,
    this.callDate,
    this.startDate,
    this.endDate,
    this.comments,
    this.progress = 0,
    required this.status,
    required this.stage,
    this.parentTask,
    this.supplier,
    this.attachments,
    required this.job,
    this.order = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        callDate,
        startDate,
        endDate,
        comments,
        progress,
        status,
        stage,
        parentTask,
        supplier,
        attachments,
        job,
        order,
      ];

  @override
  bool? get stringify => true;

  Task copyWith({
    int? id,
    String? name,
    DateTime? callDate,
    DateTime? startDate,
    DateTime? endDate,
    String? comments,
    int? progress,
    TaskStatus? status,
    TaskStage? stage,
    int? parentTask,
    Contact? supplier,
    List<dynamic>? attachments,
    int? job,
    int? order,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      callDate: callDate ?? this.callDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      comments: comments ?? this.comments,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      stage: stage ?? this.stage,
      parentTask: parentTask ?? this.parentTask,
      supplier: supplier ?? this.supplier,
      attachments: attachments ?? this.attachments,
      job: job ?? this.job,
      order: order ?? this.order,
    );
  }
}
