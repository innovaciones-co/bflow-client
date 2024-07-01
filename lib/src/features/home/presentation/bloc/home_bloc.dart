import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/alert_type.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ShowMessageEvent>(_showMessage);
    on<ShowFooterActionEvent>(_showFooterAction);
  }

  FutureOr<void> _showMessage(event, emit) {
    emit(AlertMessage(message: event.message, type: event.type));
  }

  FutureOr<void> _showFooterAction(
      ShowFooterActionEvent event, Emitter<HomeState> emit) {
    emit(FooterAction(
      leading: event.leading,
      actions: event.actions,
      onCancel: event.onCancel,
    ));
    emit(HomeInitial());
  }
}
