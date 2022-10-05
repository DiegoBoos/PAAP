import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/usuario.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../datasources/remote/auth/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UsuarioEntity>> verificarUsuario(
      String usuarioId, String contrasena) async {
    try {
      final usuarioModel =
          await authRemoteDataSource.verificarUsuario(usuarioId, contrasena);

      return Right(usuarioModel);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException {
      return const Left(ConnectionFailure(['Error de conexión']));
    }
  }
}
