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
  final bool visible;
  final Widget? leading;
  final List<Widget> actions;
  final Function()? onCancel;
  final bool showCancelButton;

  const FooterAction({
    required this.actions,
    this.onCancel,
    this.leading,
    this.visible = true,
    required this.showCancelButton,
  });

  @override
  List<Object> get props => [
        visible,
        leading ?? const SizedBox.shrink(),
        actions,
        onCancel ?? () {},
        showCancelButton,
      ];
}
