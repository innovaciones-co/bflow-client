import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:equatable/equatable.dart';

class Task implements Equatable {
  final int id;
  final String name;
  final DateTime? callDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? comments;
  final int progress;
  final TaskStatus status;
  final TaskStage stage;
  final int? parentTask;
  final int? supplier;
  final List<dynamic>? attachments;
  final int job;

  Task({
    required this.id,
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
      ];

  @override
  bool? get stringify => true;
}
