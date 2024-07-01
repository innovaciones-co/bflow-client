part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class ShowMessageEvent extends HomeEvent {
  final String message;
  final AlertType type;
  final DateTime timestamp;

  ShowMessageEvent({required this.message, this.type = AlertType.info})
      : timestamp = DateTime.now();

  @override
  List<Object> get props => [message, type, timestamp];
}

class ShowFooterActionEvent extends HomeEvent {
  final Widget? leading;
  final List<Widget> actions;
  final Function()? onCancel;

  const ShowFooterActionEvent({
    required this.actions,
    this.onCancel,
    required this.leading,
  });
}
