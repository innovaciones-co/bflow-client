import 'package:equatable/equatable.dart';

class PurchaseOrder extends Equatable {
  final int id;
  final String number;
  final dynamic sentDate;
  final dynamic approvedDate;
  final dynamic completedDate;
  final String status;
  final int job;

  const PurchaseOrder({
    required this.id,
    required this.number,
    required this.sentDate,
    required this.approvedDate,
    required this.completedDate,
    required this.status,
    required this.job,
  });

  @override
  List<Object?> get props => [
        id,
        number,
        sentDate,
        approvedDate,
        completedDate,
        status,
        job,
      ];

  @override
  bool? get stringify => true;
}
