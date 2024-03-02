import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int? id;
  final String body;
  final int? job;

  const Note({required this.id, required this.body, required this.job});

  @override
  List<Object?> get props => [id, body, job];

  @override
  bool? get stringify => true;
}
