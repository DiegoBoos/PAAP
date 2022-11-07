import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../../domain/repositories/tipo_identificacion/tipo_identificacion_repository_db.dart';
import '../../datasources/local/tipo_identificacion/tipo_identificacion_local_ds.dart';

class TipoIdentificacionRepositoryDBImpl
    implements TipoIdentificacionRepositoryDB {
  final TipoIdentificacionLocalDataSource tipoIdentificacionLocalDataSource;

  TipoIdentificacionRepositoryDBImpl(
      {required this.tipoIdentificacionLocalDataSource});

  @override
  Future<Either<Failure, List<TipoIdentificacionEntity>>>
      getTiposIdentificacionesRepositoryDB() async {
    try {
      final tipoidentificacionesDB =
          await tipoIdentificacionLocalDataSource.getTipoIdentificacionesDB();

      return Right(tipoidentificacionesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposIdentificacionesRepositoryDB(
      List<TipoIdentificacionEntity> tipoidentificacionEntity) async {
    try {
      final tipoidentificacionDB = await tipoIdentificacionLocalDataSource
          .saveTipoIdentificaciones(tipoidentificacionEntity);
      return Right(tipoidentificacionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
