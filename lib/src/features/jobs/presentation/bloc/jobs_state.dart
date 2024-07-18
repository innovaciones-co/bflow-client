// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'jobs_bloc.dart';

abstract class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object> get props => [];
}

class JobsInitial extends JobsState {}

class JobsLoading extends JobsState {}

class JobsLoaded extends JobsState {
  final List<Job> jobs;
  final String? filter;

  const JobsLoaded({required this.jobs, this.filter});

  int get completedJobs =>
      jobs.where((element) => element.progress == 1).length;

  int get inProgressJobs =>
      jobs.where((element) => element.progress != 1).length;

  List<Job> get jobsFiltered {
    if (filter == null || filter!.isEmpty) {
      return jobs;
    }

    return jobs
        .where(
          (job) =>
              job.name.search(filter!) ||
              (job.description != null
                  ? job.description!.search(filter!)
                  : false) ||
              job.jobNumber.search(filter!) ||
              job.address.search(filter!) ||
              job.user.fullName.search(filter!) ||
              job.client.name.search(filter!) ||
              job.supervisor.fullName.search(filter!),
        )
        .toList();
  }

  JobsLoaded copyWith({
    List<Job>? jobs,
    String? filter,
  }) {
    return JobsLoaded(jobs: jobs ?? this.jobs, filter: filter ?? this.filter);
  }

  @override
  List<Object> get props => [jobs, filter ?? ''];
}

class JobsError extends JobsState {
  final Failure failure;

  const JobsError(this.failure);

  @override
  List<Object> get props => [failure];
}
