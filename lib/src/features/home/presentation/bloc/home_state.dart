part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class AlertMessage extends HomeState {
  final String message;
  final AlertType type;

  const AlertMessage({required this.message, required this.type});

  @override
  List<Object> get props => [message, type];
}
