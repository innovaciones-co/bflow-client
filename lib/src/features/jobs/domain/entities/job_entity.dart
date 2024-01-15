import 'package:equatable/equatable.dart';

class Job implements Equatable {
  final int id;
  final String jobNumber;
  final String name;
  final DateTime plannedStartDate;
  final DateTime plannedEndDate;
  final String address;
  final String? description;
  final String owner;

  Job({
    required this.id,
    required this.jobNumber,
    required this.name,
    required this.plannedStartDate,
    required this.plannedEndDate,
    required this.address,
    required this.description,
    required this.owner,
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
        owner
      ];

  @override
  bool? get stringify => true;
}
