import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/estado_visita_entity.dart';
import '../../../domain/repositories/estado_visita/estado_visita_repository_db.dart';
import '../../datasources/local/estado_visita/estado_visita_local_ds.dart';

class EstadoVisitaRepositoryDBImpl implements EstadoVisitaRepositoryDB {
  final EstadoVisitaLocalDataSource estadoVisitaLocalDataSource;

  EstadoVisitaRepositoryDBImpl({required this.estadoVisitaLocalDataSource});

  @override
  Future<Either<Failure, List<EstadoVisitaEntity>>>
      getEstadosVisitasRepositoryDB() async {
    try {
      final estadovisitasDB =
          await estadoVisitaLocalDataSource.getEstadosVisitasDB();

      return Right(estadovisitasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEstadosVisitasRepositoryDB(
      List<EstadoVisitaEntity> estadovisitaEntity) async {
    try {
      final estadovisitaDB = await estadoVisitaLocalDataSource
          .saveEstadosVisitas(estadovisitaEntity);
      return Right(estadovisitaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
