enum MimeType {
  // Common MIME types
  plainText('text/plain'),
  html('text/html'),
  css('text/css'),
  javascript('application/javascript'),
  json('application/json'),
  xml('application/xml'),
  pdf('application/pdf'),
  zip('application/zip'),
  gzip('application/gzip'),

  // Image MIME types
  png('image/png'),
  jpeg('image/jpeg'),
  gif('image/gif'),
  bmp('image/bmp'),
  webp('image/webp'),

  // Audio MIME types
  mp3('audio/mpeg'),
  wav('audio/wav'),
  ogg('audio/ogg'),

  // Video MIME types
  mp4('video/mp4'),
  mpeg('video/mpeg'),
  webm('video/webm'),

  // Microsoft Office MIME types
  msWord('application/msword'),
  msExcel('application/vnd.ms-excel'),
  msPowerPoint('application/vnd.ms-powerpoint'),

  // OpenXML formats (newer Microsoft Office formats)
  msWordOpenXML(
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),
  msExcelOpenXML(
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
  msPowerPointOpenXML(
      'application/vnd.openxmlformats-officedocument.presentationml.presentation');

  final String value;
  const MimeType(this.value);
}
