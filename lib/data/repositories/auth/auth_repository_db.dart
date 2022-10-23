import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/usuario_entity.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/repositories/auth/auth_repository_db.dart';
import '../../datasources/local/auth/auth_local_ds.dart';

class AuthRepositoryDBImpl implements AuthRepositoryDB {
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryDBImpl({required this.authLocalDataSource});

  @override
  Future<Either<Failure, int>> saveUsuarioRepositoryDB(
      UsuarioEntity usuarioEntity) async {
    try {
      final usuarioDB = await authLocalDataSource.saveUsuario(usuarioEntity);
      return Right(usuarioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, UsuarioEntity?>> verificacionRepositoryDB(
      String usuarioId, String contrasena) async {
    try {
      final usuario = await authLocalDataSource.logIn(usuarioId, contrasena);

      return Right(usuario);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
