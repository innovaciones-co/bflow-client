import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobTasksWidget extends StatelessWidget {
  const JobTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is TasksLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is TasksLoaded) {
          return Column(
            children: state.tasks.map((e) => Text(e.name)).toList(),
          );
        }

        if (state is TaskError) {
          return FailureWidget(failure: state.failure);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
