import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/grupo_especial_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/grupo_especial/grupo_especial_repository.dart';
import '../../datasources/remote/grupo_especial/grupo_especial_remote_ds.dart';

class GrupoEspecialRepositoryImpl implements GrupoEspecialRepository {
  final GrupoEspecialRemoteDataSource grupoEspecialRemoteDataSource;

  GrupoEspecialRepositoryImpl({required this.grupoEspecialRemoteDataSource});

  @override
  Future<Either<Failure, List<GrupoEspecialEntity>>>
      getGruposEspecialesRepository(UsuarioEntity usuario) async {
    try {
      final tipoproyectos =
          await grupoEspecialRemoteDataSource.getGruposEspeciales(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
