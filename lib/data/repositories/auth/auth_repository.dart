import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/usuario_entity.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../datasources/remote/auth/auth_remote_ds.dart';
import '../../models/usuario_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UsuarioEntity>> verificacionRepository(
      String usuarioId, String contrasena) async {
    try {
      final result =
          await authRemoteDataSource.verificacion(usuarioId, contrasena);

      final usuario = UsuarioModel.fromJson(result['objeto']);

      return Right(usuario);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
