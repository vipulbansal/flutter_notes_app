import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  
  const Failure([this.properties = const <dynamic>[]]);
  
  @override
  List<Object> get props => [properties];
}

class CacheFailure extends Failure {
  final String message;
  
  const CacheFailure([this.message = 'Cache operation failed']);
  
  @override
  String toString() => message;
}

class UnexpectedFailure extends Failure {
  final String message;
  
  const UnexpectedFailure([this.message = 'Unexpected error occurred']);
  
  @override
  String toString() => message;
}
