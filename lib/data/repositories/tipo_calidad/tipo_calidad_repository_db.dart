import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/tipo_calidad_entity.dart';
import '../../../domain/repositories/tipo_calidad/tipo_calidad_repository_db.dart';
import '../../datasources/local/tipo_calidad_local_ds.dart';

class TipoCalidadRepositoryDBImpl implements TipoCalidadRepositoryDB {
  final TipoCalidadLocalDataSource tipoCalidadLocalDataSource;

  TipoCalidadRepositoryDBImpl({required this.tipoCalidadLocalDataSource});

  @override
  Future<Either<Failure, List<TipoCalidadEntity>>>
      getTiposCalidadesRepositoryDB() async {
    try {
      final tipocalidadesDB =
          await tipoCalidadLocalDataSource.getTiposCalidadesDB();

      return Right(tipocalidadesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposCalidadesRepositoryDB(
      List<TipoCalidadEntity> tipocalidadEntity) async {
    try {
      final tipocalidadDB = await tipoCalidadLocalDataSource
          .saveTiposCalidades(tipocalidadEntity);
      return Right(tipocalidadDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
