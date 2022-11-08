import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/tipo_discapacidad_entity.dart';
import '../../../domain/repositories/tipo_discapacidad/tipo_discapacidad_repository_db.dart';
import '../../datasources/local/tipo_discapacidad/tipo_discapacidad_local_ds.dart';

class TipoDiscapacidadRepositoryDBImpl implements TipoDiscapacidadRepositoryDB {
  final TipoDiscapacidadLocalDataSource tipoDiscapacidadLocalDataSource;

  TipoDiscapacidadRepositoryDBImpl(
      {required this.tipoDiscapacidadLocalDataSource});

  @override
  Future<Either<Failure, List<TipoDiscapacidadEntity>>>
      getTiposDiscapacidadesRepositoryDB() async {
    try {
      final tiposDiscapacidadesDB =
          await tipoDiscapacidadLocalDataSource.getTiposCalidadesDB();

      return Right(tiposDiscapacidadesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposDiscapacidadesRepositoryDB(
      List<TipoDiscapacidadEntity> tipodiscapacidadEntity) async {
    try {
      final result = await tipoDiscapacidadLocalDataSource
          .saveTiposCalidades(tipodiscapacidadEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
