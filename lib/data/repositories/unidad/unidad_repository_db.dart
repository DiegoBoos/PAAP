import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/unidad_entity.dart';
import '../../../domain/repositories/unidad/unidad_repository_db.dart';
import '../../datasources/local/unidad/unidad_local_ds.dart';

class UnidadRepositoryDBImpl implements UnidadRepositoryDB {
  final UnidadLocalDataSource unidadLocalDataSource;

  UnidadRepositoryDBImpl({required this.unidadLocalDataSource});

  @override
  Future<Either<Failure, List<UnidadEntity>>> getUnidadesRepositoryDB() async {
    try {
      final unidadesDB = await unidadLocalDataSource.getUnidadesDB();

      return Right(unidadesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUnidadesRepositoryDB(
      List<UnidadEntity> unidadEntity) async {
    try {
      final unidadDB = await unidadLocalDataSource.saveUnidades(unidadEntity);
      return Right(unidadDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
