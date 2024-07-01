// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class ToggleSelectedTask extends TasksEvent {
  final Task task;

  const ToggleSelectedTask({required this.task});
}

class AddSelectedTask extends TasksEvent {
  final Task task;

  const AddSelectedTask({required this.task});
}

class RemoveSelectedTask extends TasksEvent {
  final Task task;

  const RemoveSelectedTask({required this.task});
}

class LoadingTasksEvent extends TasksEvent {}

class DeleteTasksEvent extends TasksEvent {}

class SendSelectedTasksEvent extends TasksEvent {}

class SendTaskEvent extends TasksEvent {
  final Task task;

  const SendTaskEvent({required this.task});
}

class GetTasksEvent extends TasksEvent {
  final int? jobId;

  const GetTasksEvent({this.jobId});

  @override
  List<Object> get props => [jobId ?? 0];
}

class UpdateTasksEvent extends TasksEvent {
  final List<Task> tasks;

  const UpdateTasksEvent({required this.tasks});
}

class UpdateTaskDataEvent extends TasksEvent {
  final Task task;

  const UpdateTaskDataEvent({required this.task});
}

class SaveUpdatedTasks extends TasksEvent {}
