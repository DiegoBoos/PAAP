import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/nivel_escolar_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/nivel_escolar/nivel_escolar_repository.dart';
import '../../datasources/remote/nivel_escolar_remote_ds.dart';

class NivelEscolarRepositoryImpl implements NivelEscolarRepository {
  final NivelEscolarRemoteDataSource nivelEscolarRemoteDataSource;

  NivelEscolarRepositoryImpl({required this.nivelEscolarRemoteDataSource});

  @override
  Future<Either<Failure, List<NivelEscolarEntity>>>
      getNivelesEscolaresRepository(UsuarioEntity usuario) async {
    try {
      final tipoproyectos =
          await nivelEscolarRemoteDataSource.getNivelesEscolares(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
