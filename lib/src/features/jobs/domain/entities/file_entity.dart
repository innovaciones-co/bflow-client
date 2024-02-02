import 'package:bflow_client/src/features/jobs/domain/entities/file_category.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_tag.dart';

class File {
  final int id;
  final String uuid;
  final String temporaryUrl;
  final String? bucket;
  final String name;
  final String? type;
  final FileCategory? category;
  final FileTag? tag;
  final int? job;

  File({
    required this.id,
    required this.uuid,
    required this.temporaryUrl,
    this.bucket,
    required this.name,
    this.type,
    this.category,
    this.tag,
    this.job,
  });
}
