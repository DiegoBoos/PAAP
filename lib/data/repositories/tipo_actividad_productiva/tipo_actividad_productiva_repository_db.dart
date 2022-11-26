import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../../domain/repositories/tipo_actividad_productiva/tipo_actividad_productiva_repository_db.dart';
import '../../datasources/local/tipo_actividad_productiva_local_ds.dart';

class TipoActividadProductivaRepositoryDBImpl
    implements TipoActividadProductivaRepositoryDB {
  final TipoActividadProductivaLocalDataSource
      tipoActividadProductivaLocalDataSource;

  TipoActividadProductivaRepositoryDBImpl(
      {required this.tipoActividadProductivaLocalDataSource});

  @override
  Future<Either<Failure, List<TipoActividadProductivaEntity>>>
      getTiposActividadesProductivasRepositoryDB() async {
    try {
      final tiposActividadesProductivasDB =
          await tipoActividadProductivaLocalDataSource
              .getTiposActividadesProductivasDB();

      return Right(tiposActividadesProductivasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposActividadesProductivasRepositoryDB(
      List<TipoActividadProductivaEntity> tipoActividadProductivaEntity) async {
    try {
      final tipoActividadProductivaDB =
          await tipoActividadProductivaLocalDataSource
              .saveTiposActividadesProductivas(tipoActividadProductivaEntity);
      return Right(tipoActividadProductivaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
