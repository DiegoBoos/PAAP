import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/experiencia_pecuaria_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/experiencia_pecuaria/experiencia_pecuaria_repository.dart';
import '../../datasources/remote/experiencia_pecuaria_remote_ds.dart';

class ExperienciaPecuariaRepositoryImpl
    implements ExperienciaPecuariaRepository {
  final ExperienciaPecuariaRemoteDataSource experienciaPecuariaRemoteDataSource;

  ExperienciaPecuariaRepositoryImpl(
      {required this.experienciaPecuariaRemoteDataSource});

  @override
  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      getExperienciasPecuariasRepository(UsuarioEntity usuario) async {
    try {
      final experienciasPecuarias = await experienciaPecuariaRemoteDataSource
          .getExperienciasPecuarias(usuario);

      return Right(experienciasPecuarias);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      saveExperienciasPecuariasRepository(UsuarioEntity usuario,
          List<ExperienciaPecuariaEntity> experienciasPecuariasEntity) async {
    try {
      final result = await experienciaPecuariaRemoteDataSource
          .saveExperienciasPecuarias(usuario, experienciasPecuariasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
