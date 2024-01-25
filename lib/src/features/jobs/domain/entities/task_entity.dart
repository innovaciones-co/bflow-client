import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';

class Task {
  final int id;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
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
    this.startDate,
    this.endDate,
    this.progress = 0,
    required this.status,
    required this.stage,
    this.parentTask,
    this.supplier,
    this.attachments,
    required this.job,
  });
}
