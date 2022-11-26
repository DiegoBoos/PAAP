import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/residencia_entity.dart';
import '../../../domain/repositories/residencia/residencia_repository_db.dart';
import '../../datasources/local/residencia_local_ds.dart';

class ResidenciaRepositoryDBImpl implements ResidenciaRepositoryDB {
  final ResidenciaLocalDataSource residenciaLocalDataSource;

  ResidenciaRepositoryDBImpl({required this.residenciaLocalDataSource});

  @override
  Future<Either<Failure, List<ResidenciaEntity>>>
      getResidenciasRepositoryDB() async {
    try {
      final residenciasDB = await residenciaLocalDataSource.getResidenciasDB();

      return Right(residenciasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveResidenciaRepositoryDB(
      List<ResidenciaEntity> residenciaEntity) async {
    try {
      final residenciaDB =
          await residenciaLocalDataSource.saveResidencias(residenciaEntity);
      return Right(residenciaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
