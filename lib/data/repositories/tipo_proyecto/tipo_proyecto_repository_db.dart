import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/tipo_proyecto_entity.dart';
import '../../../domain/repositories/tipo_proyecto/tipo_proyecto_repository_db.dart';
import '../../datasources/local/tipo_proyecto/tipo_proyecto_local_ds.dart';

class TipoProyectoRepositoryDBImpl implements TipoProyectoRepositoryDB {
  final TipoProyectoLocalDataSource tipoProyectoLocalDataSource;

  TipoProyectoRepositoryDBImpl({required this.tipoProyectoLocalDataSource});

  @override
  Future<Either<Failure, List<TipoProyectoEntity>>>
      getTiposProyectosRepositoryDB() async {
    try {
      final tipoproyectosDB =
          await tipoProyectoLocalDataSource.getTiposProyectosDB();

      return Right(tipoproyectosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposProyectosRepositoryDB(
      List<TipoProyectoEntity> tipoproyectoEntity) async {
    try {
      final tipoproyectoDB = await tipoProyectoLocalDataSource
          .saveTiposProyectos(tipoproyectoEntity);
      return Right(tipoproyectoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
