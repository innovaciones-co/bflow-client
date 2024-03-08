class ApiConstants {
  static String baseUrl = 'http://localhost:8080/api';

  static String listJobsEndpoint = 'jobs';
  static String getJobEndpoint = 'jobs/:id';

  static String taskEndpoint = 'tasks/:id';

  static String listTasksEndpoint = 'tasks';
  static String listUsersEndpoint = 'users';
  static String loginUsersEndpoint = 'users/login';

  static String contactsEndpoint = 'contacts';
  static String contactEndpoint = 'contacts/:id';

  static String notesEndpoint = 'notes';
  static String noteEndpoint = 'notes/:id';

  static String templatesEndpoint = 'templates';
  static String createTaskFromTemplateEndpoint = 'templates/:id/tasks';

  static String fileEndpoint = 'files/:id';
  static String uploadFileEndpoint = 'files/upload';
}
