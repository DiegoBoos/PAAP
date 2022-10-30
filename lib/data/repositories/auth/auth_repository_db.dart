import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
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
      UsuarioEntity usuario) async {
    try {
      final usuarioEntity = await authLocalDataSource.logIn(usuario);

      return Right(usuarioEntity);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
