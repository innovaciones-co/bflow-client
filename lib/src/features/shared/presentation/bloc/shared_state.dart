part of 'shared_bloc.dart';

abstract class SharedState extends Equatable {
  const SharedState();  

  @override
  List<Object> get props => [];
}
class SharedInitial extends SharedState {}
