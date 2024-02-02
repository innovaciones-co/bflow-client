import 'package:equatable/equatable.dart';

class Note implements Equatable {
  final int? id;
  final String body;
  final int? job;

  Note({required this.id, required this.body, required this.job});

  @override
  List<Object?> get props => [id, body, job];

  @override
  bool? get stringify => true;
}
