import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/utils/input_formatters/range_input_formatter.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/date_picker_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/write_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteActivityWidget extends StatelessWidget with Validator {
  final _formKey = GlobalKey<FormState>();

  WriteActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WriteTaskCubit>(
      create: (context) => WriteTaskCubit(tasks: [
        null,
        Task(
            id: 1000,
            name: "Name",
            status: TaskStatus.created,
            stage: TaskStage.slabDown,
            job: 10001),
        Task(
            id: 1001,
            name: "Name",
            status: TaskStatus.created,
            stage: TaskStage.slabDown,
            job: 10001),
        Task(
            id: 1002,
            name: "Name",
            status: TaskStatus.created,
            stage: TaskStage.slabDown,
            job: 10001),
        Task(
            id: 1003,
            name: "Name",
            status: TaskStatus.created,
            stage: TaskStage.slabDown,
            job: 10001),
      ], suppliers: [
        Contact(id: 1, name: "Test", email: "test", type: ContactType.supplier),
        Contact(id: 1, name: "Test", email: "test", type: ContactType.supplier),
        Contact(id: 1, name: "Test", email: "test", type: ContactType.supplier),
      ]),
      child: BlocBuilder<WriteTaskCubit, WriteTaskState>(
        builder: (context, state) {
          final writeTaskBloc = context.read<WriteTaskCubit>();
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputWidget(
                  label: "Name Task",
                  onChanged: writeTaskBloc.updateName,
                  initialValue: state.name,
                ),
                const SizedBox(height: 20),
                DropdownWidget<Task?>(
                  label: "Parent Task",
                  items: writeTaskBloc.tasks,
                  getLabel: (a) => a?.name ?? '(No parent)',
                  onChanged: writeTaskBloc.updateParentTask,
                  initialValue: state.parentTask != null
                      ? writeTaskBloc.tasks
                          .where((element) => element?.id == state.parentTask)
                          .first
                      : null,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownWidget<Contact>(
                        label: "Supplier",
                        items: writeTaskBloc.suppliers,
                        getLabel: (r) => r.name,
                        onChanged: null,
                        initialValue: state.supplier,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownWidget<TaskStatus>(
                        label: "Status",
                        items: TaskStatus.values,
                        getLabel: (r) => r.name,
                        onChanged: null,
                        initialValue: null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownWidget<TaskStage>(
                        label: "Stage",
                        items: TaskStage.values,
                        getLabel: (i) => i.name,
                        onChanged: writeTaskBloc.updateStage,
                        initialValue: state.taskStage,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InputWidget(
                        label: "Progress",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RangeInputFormatter()
                        ],
                        validator: validateProgress,
                        onChanged: writeTaskBloc.updateProgress,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DatePickerWidget(
                        label: "Booking Date",
                        onChange: writeTaskBloc.updateStartDate,
                        initialValue: state.startDate,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: DatePickerWidget(
                        label: "End Date",
                        onChange: writeTaskBloc.updateEndDate,
                        initialValue: state.endDate,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Comments",
                  onChanged: writeTaskBloc.updateDescription,
                  initialValue: state.description,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButtonWidget(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      type: ButtonType.textButton,
                      title: "Cancel",
                      paddingHorizontal: 15,
                      paddingVertical: 18,
                    ),
                    const SizedBox(width: 12),
                    ActionButtonWidget(
                      onPressed: () {},
                      type: ButtonType.elevatedButton,
                      title: "Send email",
                      backgroundColor: AppColor.lightBlue,
                    ),
                    const SizedBox(width: 12),
                    ActionButtonWidget(
                      onPressed: () {},
                      type: ButtonType.elevatedButton,
                      title: "Save",
                      backgroundColor: AppColor.blue,
                      foregroundColor: AppColor.white,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
