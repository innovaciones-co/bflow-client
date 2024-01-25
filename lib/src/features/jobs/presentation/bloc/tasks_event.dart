// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetTasksEvent extends TasksEvent {
  final int jobId;

  const GetTasksEvent({required this.jobId});
}
