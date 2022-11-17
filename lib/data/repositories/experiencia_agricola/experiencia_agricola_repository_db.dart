import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/experiencia_agricola_entity.dart';
import '../../../domain/repositories/experiencia_agricola/experiencia_agricola_repository_db.dart';
import '../../datasources/local/experiencia_agricola_local_ds.dart';

class ExperienciaAgricolaRepositoryDBImpl
    implements ExperienciaAgricolaRepositoryDB {
  final ExperienciaAgricolaLocalDataSource experienciaAgricolaLocalDataSource;

  ExperienciaAgricolaRepositoryDBImpl(
      {required this.experienciaAgricolaLocalDataSource});

  @override
  Future<Either<Failure, List<ExperienciaAgricolaEntity>>>
      getExperienciasAgricolasRepositoryDB() async {
    try {
      final experienciasAgricolasDB =
          await experienciaAgricolaLocalDataSource.getExperienciasAgricolasDB();

      return Right(experienciasAgricolasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, ExperienciaAgricolaEntity?>>
      getExperienciaAgricolaRepositoryDB(String id) async {
    try {
      final experienciaAgricolaDB =
          await experienciaAgricolaLocalDataSource.getExperienciaAgricolaDB(id);

      return Right(experienciaAgricolaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveExperienciasAgricolasRepositoryDB(
      List<ExperienciaAgricolaEntity> experienciaAgricolaEntity) async {
    try {
      final experienciaAgricolaDB = await experienciaAgricolaLocalDataSource
          .saveExperienciasAgricolas(experienciaAgricolaEntity);
      return Right(experienciaAgricolaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
