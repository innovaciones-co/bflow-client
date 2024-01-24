part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class ShowMessageEvent extends HomeEvent {
  final String message;
  final AlertType type;

  const ShowMessageEvent({required this.message, this.type = AlertType.info});

  @override
  List<Object> get props => [message, type];
}
