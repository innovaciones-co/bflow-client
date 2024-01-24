import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/alert_type.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ShowMessageEvent>(_showMessage);
  }

  FutureOr<void> _showMessage(event, emit) {
    emit(AlertMessage(message: event.message, type: event.type));
  }
}
