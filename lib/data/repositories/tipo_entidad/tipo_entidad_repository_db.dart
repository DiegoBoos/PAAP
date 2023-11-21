import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/tipo_entidad_entity.dart';
import '../../../domain/repositories/tipo_entidad/tipo_entidad_repository_db.dart';
import '../../datasources/local/tipo_entidad_local_ds.dart';

class TipoEntidadRepositoryDBImpl implements TipoEntidadRepositoryDB {
  final TipoEntidadLocalDataSource tipoEntidadLocalDataSource;

  TipoEntidadRepositoryDBImpl({required this.tipoEntidadLocalDataSource});

  @override
  Future<Either<Failure, List<TipoEntidadEntity>>>
      getTiposEntidadesRepositoryDB() async {
    try {
      final tipoentidadesDB =
          await tipoEntidadLocalDataSource.getTiposEntidadesDB();

      return Right(tipoentidadesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTiposEntidadesRepositoryDB(
      List<TipoEntidadEntity> tipoentidadEntity) async {
    try {
      final tipoentidadDB = await tipoEntidadLocalDataSource
          .saveTiposEntidades(tipoentidadEntity);
      return Right(tipoentidadDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
