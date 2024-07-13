import 'package:bflow_client/src/core/config/injection.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/confirmation_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/note_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/notes/notes_cubit.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class JobNote extends StatefulWidget {
  final Note note;
  final int jobId;
  final JobBloc jobBloc;

  const JobNote({
    super.key,
    required this.note,
    required this.jobId,
    required this.jobBloc,
  });

  @override
  State<JobNote> createState() => _JobNoteState();
}

class _JobNoteState extends State<JobNote> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(
        createNoteUsecase: DependencyInjection.sl(),
        deleteNoteUseCase: DependencyInjection.sl(),
        updateNoteUseCase: DependencyInjection.sl(),
        jobId: widget.jobId,
        jobBloc: widget.jobBloc,
        homeBloc: context.read(),
      ),
      child: Builder(builder: (context) {
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovering = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovering = false;
            });
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
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
                child: BlocBuilder<NotesCubit, NotesState>(
                  builder: (context, state) {
                    if (state is NotesLoading) {
                      return const LoadingWidget();
                    }

                    if (state is NotesEditing) {
                      return _buildEditNote(state, context);
                    }

                    return Text(widget.note.body);
                  },
                ),
              ),
              BlocSelector<NotesCubit, NotesState, bool>(
                selector: (state) {
                  return state is NotesEditing;
                },
                builder: (context, isEditing) {
                  return isEditing
                      ? const SizedBox.shrink()
                      : _listNoteOptions(context);
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  AnimatedPositioned _listNoteOptions(BuildContext context) {
    return AnimatedPositioned(
      top: _isHovering ? 10 : -50,
      right: 10,
      duration: const Duration(milliseconds: 250),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.read<NotesCubit>().editNote(widget.note);
            },
            color: AppColor.blue,
            icon: const Icon(
              Icons.edit_outlined,
              size: 20,
            ),
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: () {
              context.showCustomModal(
                ConfirmationWidget(
                  title: "Delete note",
                  description: "Are you sure you want to delete this note?",
                  onConfirm: () {
                    context.read<NotesCubit>().deleteNote(widget.note.id!);
                    context.pop();
                  },
                  confirmText: "Delete",
                ),
              );
            },
            color: AppColor.blue,
            icon: const Icon(
              Icons.delete_outline_outlined,
              size: 20,
            ),
            tooltip: 'Delete',
          ),
        ],
      ),
    );
  }

  Column _buildEditNote(NotesEditing state, BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
          ),
          initialValue: state.note?.body ?? "",
          minLines: 3,
          maxLines: 5,
          onChanged: context.read<NotesCubit>().updateNoteBody,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButtonWidget(
                onPressed: () {
                  context.read<NotesCubit>().cancelEditNote();
                },
                type: ButtonType.elevatedButton,
                title: "Cancel",
              ),
              const SizedBox(width: 10),
              ActionButtonWidget(
                onPressed: () {
                  context.read<NotesCubit>().updateNote(widget.note);
                },
                type: ButtonType.elevatedButton,
                title: "Save",
                backgroundColor: AppColor.blue,
                foregroundColor: AppColor.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}
