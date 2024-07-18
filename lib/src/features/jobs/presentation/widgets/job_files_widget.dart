import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/confirmation_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/files/files_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/notes/notes_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/file_download_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/file_upload_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class JobFilesWidget extends StatelessWidget {
  const JobFilesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilesCubit>(
      create: (context) => DependencyInjection.sl(),
      child: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is JobLoaded) {
            var jobId = state.job.id;

            return BlocListener<FilesCubit, FilesState>(
              listener: (context, state) {
                if (state is FilesDeleted) {
                  context.showAlert(
                    message: "The files were deleted",
                    type: AlertType.success,
                  );

                  if (jobId != null) {
                    context.read<JobBloc>().add(GetJobEvent(id: jobId));
                  }
                }

                if (state is FilesError) {
                  context.showAlert(
                    message: state.failure.message ?? "Unexpectd error",
                    type: AlertType.error,
                  );
                }
              },
              child: Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Documents"),
                        _actions(context, state)
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocSelector<FilesCubit, FilesState, bool>(
                      selector: (state) {
                        return state is FilesLoading;
                      },
                      builder: (context, isLoading) {
                        if (isLoading) {
                          return const LoadingWidget();
                        }

                        return state.job.files != null
                            ? SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  spacing: 10,
                                  alignment: WrapAlignment.start,
                                  children: state.job.files!
                                      .map((e) => FileDownloadWidget(
                                            file: e,
                                          ))
                                      .toList(),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Job Notes"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    state.job.notes != null
                        ? _listNotes(state, context)
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Row _actions(BuildContext context, JobLoaded state) {
    return Row(
      children: [
        BlocSelector<FilesCubit, FilesState, int>(
          selector: (state) {
            if (state is FilesSelected) {
              return state.selectedFiles.length;
            }
            return 0;
          },
          builder: (context, selectedItems) {
            return selectedItems == 0
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: ActionButtonWidget(
                      onPressed: () {
                        context.showCustomModal(
                          ConfirmationWidget(
                            title: "Delete files",
                            description:
                                "Are you sure you want to delete ($selectedItems) file(s)?",
                            onConfirm: () {
                              context.read<FilesCubit>().deleteFiles();
                              context.pop();
                            },
                            confirmText: "Delete",
                          ),
                        );
                      },
                      type: ButtonType.elevatedButton,
                      title: "Delete",
                      icon: Icons.delete_outlined,
                    ),
                  );
          },
        ),
        ActionButtonWidget(
          onPressed: () => context.showModal("Upload file", [
            FileUploadWidget(
              jobId: state.job.id,
              jobBloc: context.read<JobBloc>(),
            ),
          ]),
          type: ButtonType.elevatedButton,
          title: "Attach",
          icon: Icons.attach_file_outlined,
          backgroundColor: AppColor.blue,
          foregroundColor: AppColor.white,
        ),
      ],
    );
  }

  Widget _listNotes(JobLoaded state, BuildContext context) {
    return Column(
      children: state.job.notes!
          .map(
            (e) => Container(
              width: context.width / 2,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.grey,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(2, 2), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(25.0),
              child: Text(e.body),
            ),
          )
          .toList()
        ..add(
          _buildAddNote(context),
        ),
    );
  }

  Container _buildAddNote(BuildContext context) {
    return Container(
      width: context.width / 2,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(25.0),
      child: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is! JobLoaded) {
            return const SizedBox.shrink();
          }
          return BlocProvider(
            create: (context) => NotesCubit(
              createNoteUsecase: DependencyInjection.sl(),
              jobId: (state).job.id!,
              jobBloc: context.read(),
            ),
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                var bloc = context.read<NotesCubit>();

                if (state is NotesLoading) {
                  return const LoadingWidget();
                }

                return Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                      minLines: 3,
                      maxLines: 5,
                      onChanged: bloc.updateNote,
                    ),
                    state.note != null
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ActionButtonWidget(
                                  onPressed: bloc.addNote,
                                  type: ButtonType.elevatedButton,
                                  title: "Create note",
                                  backgroundColor: AppColor.blue,
                                  foregroundColor: AppColor.white,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
