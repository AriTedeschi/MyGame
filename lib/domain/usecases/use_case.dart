import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_game/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params param);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}