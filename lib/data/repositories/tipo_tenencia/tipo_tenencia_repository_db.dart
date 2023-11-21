import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/tipo_tenencia_entity.dart';
import '../../../domain/repositories/tipo_tenencia/tipo_tenencia_repository_db.dart';
import '../../datasources/local/tipo_tenencia_local_ds.dart';

class TipoTenenciaRepositoryDBImpl implements TipoTenenciaRepositoryDB {
  final TipoTenenciaLocalDataSource tipoTenenciaLocalDataSource;

  TipoTenenciaRepositoryDBImpl({required this.tipoTenenciaLocalDataSource});

  @override
  Future<Either<Failure, List<TipoTenenciaEntity>>>
      getTiposTenenciasRepositoryDB() async {
    try {
      final tipotenenciasDB =
          await tipoTenenciaLocalDataSource.getTiposTenenciasDB();

      return Right(tipotenenciasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposTenenciasRepositoryDB(
      List<TipoTenenciaEntity> tipotenenciaEntity) async {
    try {
      final tipotenenciaDB = await tipoTenenciaLocalDataSource
          .saveTiposTenencias(tipotenenciaEntity);
      return Right(tipotenenciaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
