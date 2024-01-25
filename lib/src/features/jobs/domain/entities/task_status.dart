enum TaskStatus {
  created('Created'),
  inProgress('In Progress'),
  completed('Completed'),
  canceled('Canceled'),
  sent('Sent'),
  confirmed('Confirmed'),
  declined('Declined'),
  reschedule('Reschedule');

  final String name;
  const TaskStatus(this.name);

  @override
  String toString() => name;

  String toJSON() => name.toUpperCase().replaceAll(' ', '_');

  static TaskStatus fromString(String str) {
    switch (str.toLowerCase()) {
      case "created":
        return TaskStatus.created;
      case "in_progress":
        return TaskStatus.inProgress;
      case "completed":
        return TaskStatus.completed;
      case "canceled":
        return TaskStatus.canceled;
      case "sent":
        return TaskStatus.sent;
      case "confirmed":
        return TaskStatus.confirmed;
      case "declined":
        return TaskStatus.declined;
      case "reschedule":
        return TaskStatus.reschedule;
      default:
        return TaskStatus.created;
    }
  }
}
