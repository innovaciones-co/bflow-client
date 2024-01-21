import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:equatable/equatable.dart';

import '../../../users/domain/entities/user_entity.dart';

class Job implements Equatable {
  final int id;
  final String jobNumber;
  final String name;
  final DateTime plannedStartDate;
  final DateTime plannedEndDate;
  final String address;
  final String? description;
  final int? client;
  final User user;
  final TaskStage stage;
  final double progress;

  Job({
    required this.id,
    required this.jobNumber,
    required this.name,
    required this.plannedStartDate,
    required this.plannedEndDate,
    required this.address,
    this.description,
    this.client,
    required this.user,
    this.stage = TaskStage.slabDown,
    this.progress = 0,
  });

  @override
  List<Object?> get props => [
        id,
        jobNumber,
        name,
        plannedEndDate,
        plannedEndDate,
        address,
        description,
        user
      ];

  @override
  bool? get stringify => true;

  int get daysOfConstruction => progress == 1
      ? plannedStartDate.daysDifference(plannedEndDate)
      : plannedStartDate.daysDifference(DateTime.now());
}
