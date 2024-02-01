import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:bflow_client/src/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersBloc>(
      create: (context) {
        UsersBloc usersBloc = DependencyInjection.sl();
        usersBloc.add(GetUsersEvent());
        return usersBloc;
      },
      child: PageContainerWidget(
        title: 'Users',
        actions: [
          ActionButtonWidget(
            onPressed: null,
            type: ButtonType.elevatedButton,
            title: "New user",
          ),
        ],
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading || state is UsersInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UsersError) {
              return FailureWidget(
                failure: state.failure,
              );
            }
            if (state is UsersLoaded) {
              var users = state.users;
              return _usersTable(context, users);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Table _usersTable(BuildContext context, List<User> users) {
    return Table(
      border: TableBorder.all(
        color: AppColor.grey,
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColor.grey,
          ),
          children: [
            _tableHeader(context, "Username"),
            _tableHeader(context, "First Name"),
            _tableHeader(context, "Last Name"),
            _tableHeader(context, "Email"),
            _tableHeader(context, "Role"),
            _tableHeader(context, "Actions"),
          ],
        ),
        ...users.map(
          (e) => TableRow(
            decoration: BoxDecoration(
              color: AppColor.white,
            ),
            children: [
              _tableData(context, e.username),
              _tableData(context, e.firstName),
              _tableData(context, e.lastName),
              _tableData(context, e.email),
              _tableData(context, e.role.toString()),
              _tableActions(context),
            ],
          ),
        )
      ],
    );
  }

  _tableHeader(BuildContext context, String label) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          label,
          style: context.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  _tableData(BuildContext context, String label) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(label, style: context.bodyMedium),
      ),
    );
  }

  _tableActions(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: null, icon: Icon(Icons.edit_outlined)),
            IconButton(
                onPressed: null, icon: Icon(Icons.delete_outline_outlined))
          ],
        ),
      ),
    );
  }
}
