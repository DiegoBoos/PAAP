import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/tipo_visita_entity.dart';
import '../../../domain/repositories/tipo_visita/tipo_visita_repository_db.dart';
import '../../datasources/local/tipo_visita/tipo_visita_local_ds.dart';

class TipoVisitaRepositoryDBImpl implements TipoVisitaRepositoryDB {
  final TipoVisitaLocalDataSource tipoVisitaLocalDataSource;

  TipoVisitaRepositoryDBImpl({required this.tipoVisitaLocalDataSource});

  @override
  Future<Either<Failure, List<TipoVisitaEntity>>>
      getTiposVisitasRepositoryDB() async {
    try {
      final tipovisitasDB = await tipoVisitaLocalDataSource.getTiposVisitasDB();

      return Right(tipovisitasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposVisitasRepositoryDB(
      List<TipoVisitaEntity> tipovisitaEntity) async {
    try {
      final tipovisitaDB =
          await tipoVisitaLocalDataSource.saveTiposVisitas(tipovisitaEntity);
      return Right(tipovisitaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
