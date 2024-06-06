class ApiConstants {
  static String baseUrl = 'http://localhost:8080/api';
  //static String baseUrl = 'http://10.0.2.2:8080/api';
  //static String baseUrl = 'https://bflowserver.innovaciones.co/api';

  static String listJobsEndpoint = 'jobs';
  static String getJobEndpoint = 'jobs/:id';

  static String taskEndpoint = 'tasks/:id';
  static String tasksEndpoint = 'tasks';
  static String sendTasksEndpoint = 'tasks/send';

  static String usersEndpoint = 'users';
  static String userEndpoint = 'users/:id';
  static String userByusernameEndpoint = 'users/username/:username';
  static String loginUsersEndpoint = 'users/login';

  static String contactsEndpoint = 'contacts';
  static String contactEndpoint = 'contacts/:id';

  static String notesEndpoint = 'notes';
  static String noteEndpoint = 'notes/:id';

  static String templatesEndpoint = 'templates';
  static String createFromTemplateEndpoint = 'templates/:id';

  static String fileEndpoint = 'files/:id';
  static String uploadFileEndpoint = 'files/upload';

  static String listCategoriesEndpoint = 'categories';
  static String getCategoryEndpoint = 'categories/:id';

  static String productsEndpoint = 'products';
  static String productEndpoint = 'products/:id';

  static String listPurchaseOrdersEndpoint = 'purchaseOrders';
  static String getPurchaseOrderEndpoint = 'purchaseOrders/:id';
  static String purchaseOrderFromItemsEndpoint = 'purchaseOrders/items';

  static String listItemsEndpoint = 'items';
  static String getItemEndpoint = 'items/:id';
  static String createPurchaseOrderEndpoint = 'items/purchaeOrders';
}
