import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/experiencia_pecuaria_entity.dart';
import '../../../domain/repositories/experiencia_pecuaria/experiencia_pecuaria_repository_db.dart';
import '../../datasources/local/experiencia_pecuaria_local_ds.dart';

class ExperienciaPecuariaRepositoryDBImpl
    implements ExperienciaPecuariaRepositoryDB {
  final ExperienciaPecuariaLocalDataSource experienciaPecuariaLocalDataSource;

  ExperienciaPecuariaRepositoryDBImpl(
      {required this.experienciaPecuariaLocalDataSource});

  @override
  Future<Either<Failure, List<ExperienciaPecuariaEntity>>>
      getExperienciasPecuariasRepositoryDB() async {
    try {
      final experienciasPecuariasDB =
          await experienciaPecuariaLocalDataSource.getExperienciasPecuariasDB();

      return Right(experienciasPecuariasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, ExperienciaPecuariaEntity?>>
      getExperienciaPecuariaRepositoryDB(String id) async {
    try {
      final experienciaPecuariaDB =
          await experienciaPecuariaLocalDataSource.getExperienciaPecuariaDB(id);

      return Right(experienciaPecuariaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveExperienciasPecuariasRepositoryDB(
      List<ExperienciaPecuariaEntity> experienciaPecuariaEntity) async {
    try {
      final experienciaPecuariaDB = await experienciaPecuariaLocalDataSource
          .saveExperienciasPecuarias(experienciaPecuariaEntity);
      return Right(experienciaPecuariaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
