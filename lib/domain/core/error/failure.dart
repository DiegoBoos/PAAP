import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  @override
  //TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ConnectionFailure extends Failure {
  @override
  //TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DatabaseFailure extends Failure {
  @override
  //TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
