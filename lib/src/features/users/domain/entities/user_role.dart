enum UserRole {
  admin,
  supervisor;

  @override
  @override
  String toString() {
    switch (this) {
      case UserRole.admin:
        return "Admin";
      default:
        return "Supervisor";
    }
  }

  static UserRole fromString(String str) {
    switch (str.toLowerCase()) {
      case "admin":
        return UserRole.admin;
      case "supervisor":
        return UserRole.supervisor;
      default:
        return UserRole.supervisor;
    }
  }
}
