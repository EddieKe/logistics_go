import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.message = 'An unexpected error occurred'});
  final String message;

  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
    const ServerFailure({String? message}) : super(message: message ?? 'A server error occurred.');
}

class CacheFailure extends Failure {
    const CacheFailure({String? message}) : super(message: message ?? 'A cache error occurred.');
}