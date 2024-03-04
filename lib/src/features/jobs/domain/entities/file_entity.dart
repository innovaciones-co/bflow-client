import 'package:bflow_client/src/features/jobs/domain/entities/file_category.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_tag.dart';
import 'package:equatable/equatable.dart';

class File extends Equatable {
  final int id;
  final String uuid;
  final String temporaryUrl;
  final String? bucket;
  final String name;
  final String? type;
  final FileCategory? category;
  final FileTag? tag;
  final int? job;
  final int? task;

  const File({
    required this.id,
    required this.uuid,
    required this.temporaryUrl,
    this.bucket,
    required this.name,
    this.type,
    this.category,
    this.tag,
    this.job,
    this.task,
  });

  @override
  List<Object?> get props => [
        id,
        uuid,
        temporaryUrl,
        bucket,
        name,
        type,
        category,
        tag,
        job,
        task,
      ];

  @override
  bool? get stringify => true;
}
