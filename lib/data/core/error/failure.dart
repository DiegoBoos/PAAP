import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure(this.properties);

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {
  const ServerFailure(List properties) : super(properties);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(List properties) : super(properties);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(List properties) : super(properties);
}
