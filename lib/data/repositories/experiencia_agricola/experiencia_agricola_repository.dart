import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/experiencia_agricola_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/experiencia_agricola/experiencia_agricola_repository.dart';
import '../../datasources/remote/experiencia_agricola_remote_ds.dart';

class ExperienciaAgricolaRepositoryImpl
    implements ExperienciaAgricolaRepository {
  final ExperienciaAgricolaRemoteDataSource experienciaAgricolaRemoteDataSource;

  ExperienciaAgricolaRepositoryImpl(
      {required this.experienciaAgricolaRemoteDataSource});

  @override
  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      getExperienciasAgricolasRepository(UsuarioEntity usuario) async {
    try {
      final experienciasAgricolas = await experienciaAgricolaRemoteDataSource
          .getExperienciasAgricolas(usuario);

      return Right(experienciasAgricolas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
