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
  final DateTime timestamp;

  AlertMessage({required this.message, required this.type, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  @override
  List<Object> get props => [message, type, timestamp];
}

class FooterAction extends HomeState {
  final Widget? leading;
  final List<Widget> actions;
  final Function()? onCancel;

  const FooterAction({
    required this.actions,
    this.onCancel,
    required this.leading,
  });
}
