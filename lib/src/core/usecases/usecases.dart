import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
