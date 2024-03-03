import 'package:equatable/equatable.dart';

class TemplateEntity extends Equatable {
  final int id;
  final String name;

  const TemplateEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}
