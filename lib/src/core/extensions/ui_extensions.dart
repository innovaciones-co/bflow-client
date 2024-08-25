import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:flutter/material.dart';

extension TaskUIExtension on Task {
  Color get statusColor {
    switch (status) {
      case TaskStatus.created:
        return AppColor.grey;
      case TaskStatus.completed:
        return AppColor.lightGreen;
      case TaskStatus.reschedule:
        return AppColor.lightOrange;
      case TaskStatus.sent:
        return AppColor.lightPurple;
      case TaskStatus.declined:
      case TaskStatus.canceled:
        return AppColor.lightRed;
      case TaskStatus.confirmed:
      case TaskStatus.inProgress:
        return AppColor.lightBlue2;
    }
  }

  Color get labelStatusColor {
    switch (status) {
      case TaskStatus.created:
        return AppColor.black;
      case TaskStatus.completed:
        return AppColor.green;
      case TaskStatus.reschedule:
        return AppColor.orange;
      case TaskStatus.sent:
        return AppColor.purple;
      case TaskStatus.declined:
      case TaskStatus.canceled:
        return AppColor.white;
      case TaskStatus.confirmed:
      case TaskStatus.inProgress:
        return AppColor.blue;
    }
  }

  Color get backgroundStatusColor {
    switch (status) {
      case TaskStatus.completed:
        return AppColor.lightGreen.withOpacity(0.4);
      default:
        return AppColor.white;
    }
  }
}
