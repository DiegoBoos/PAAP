import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../datasources/remote/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UsuarioEntity>> verificacionRepository(
      UsuarioEntity usuarioEntity) async {
    try {
      final usuario = await authRemoteDataSource.verificacion(usuarioEntity);

      return Right(usuario);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
