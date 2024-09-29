import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/confirmation_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:bflow_client/src/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/write_user_widget.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersBloc>(
      create: (_) => DependencyInjection.sl()..add(GetUsersEvent()),
      child: PageContainerWidget(
        title: 'Users',
        actions: [
          Builder(builder: (context) {
            return ActionButtonWidget(
              onPressed: () {
                UsersBloc usersBloc = context.read<UsersBloc>();
                return context.showLeftDialog(
                  'New User',
                  WriteUserWidget(
                    usersBloc: usersBloc,
                  ),
                );
              },
              icon: Icons.add,
              type: ButtonType.elevatedButton,
              title: "New user",
              backgroundColor: AppColor.blue,
              foregroundColor: AppColor.white,
            );
          }),
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
              return context.isMobile || context.isSmallTablet
                  ? _usersMobile(context, users)
                  : _usersDesktop(context, users);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _usersMobile(BuildContext context, List<User> users) {
    return Column(
      children: [
        ...users.map(
          (e) => Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: AppColor.lightGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: Row(
                            children: [
                              _cellFeature(
                                title: "Email",
                                flex: 1,
                                child: Text(e.email),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, right: 25, left: 25),
                          child: Row(
                            children: [
                              _cellFeature(
                                title: "User",
                                flex: 1,
                                child: Text(e.username),
                              ),
                              _cellFeature(
                                title: "Role",
                                flex: 1,
                                child: Text(e.role.toString()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 3,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.showCustomModal(
                          ConfirmationWidget(
                            title: "Delete user",
                            description:
                                "Are you sure you want to delete user \"${e.username}\"?",
                            onConfirm: () {
                              context
                                  .read<UsersBloc>()
                                  .add(DeleteUserEvent(userId: e.id!));
                              context.pop();
                            },
                            confirmText: "Delete",
                          ),
                        );
                      },
                      color: AppColor.blue,
                      icon: const Icon(
                        Icons.delete_outline_outlined,
                        size: 16,
                      ),
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      onPressed: () => context.showLeftDialog(
                        "Edit Contact",
                        WriteUserWidget(
                          usersBloc: context.read(),
                          user: e,
                        ),
                      ),
                      color: AppColor.blue,
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 16,
                      ),
                      tooltip: 'Edit',
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _cellFeature(
      {required String title, required int flex, required Widget child}) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColor.darkGrey),
          ),
          const SizedBox(height: 3),
          child,
        ],
      ),
    );
  }

  Table _usersDesktop(BuildContext context, List<User> users) {
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
              _tableActions(context, e),
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

  _tableActions(BuildContext context, User user) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.isTablet ? 30 : null,
              height: context.isTablet ? 30 : null,
              child: IconButton(
                onPressed: () => context.showLeftDialog(
                  "Edit Contact",
                  WriteUserWidget(
                    usersBloc: context.read(),
                    user: user,
                  ),
                ),
                color: AppColor.blue,
                icon: Icon(
                  Icons.edit_outlined,
                  size: context.isTablet ? 15 : 24,
                ),
                tooltip: 'Edit',
              ),
            ),
            SizedBox(
              width: context.isTablet ? 30 : null,
              height: context.isTablet ? 30 : null,
              child: IconButton(
                onPressed: () {
                  context.showCustomModal(
                    ConfirmationWidget(
                      title: "Delete user",
                      description:
                          "Are you sure you want to delete user \"${user.username}\"?",
                      onConfirm: () {
                        context
                            .read<UsersBloc>()
                            .add(DeleteUserEvent(userId: user.id!));
                        context.pop();
                      },
                      confirmText: "Delete",
                    ),
                  );
                },
                color: AppColor.blue,
                icon: Icon(
                  Icons.delete_outline_outlined,
                  size: context.isTablet ? 15 : 20,
                ),
                tooltip: 'Delete',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
