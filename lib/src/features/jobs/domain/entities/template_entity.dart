import 'package:equatable/equatable.dart';

class TemplateEntity implements Equatable {
  final int id;
  final String name;

  TemplateEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}
