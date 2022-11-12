import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/sitio_entrega_entity.dart';
import '../../../domain/repositories/sitio_entrega/sitio_entrega_repository_db.dart';
import '../../datasources/local/sitio_entrega/sitio_entrega_local_ds.dart';

class SitioEntregaRepositoryDBImpl implements SitioEntregaRepositoryDB {
  final SitioEntregaLocalDataSource sitioEntregaLocalDataSource;

  SitioEntregaRepositoryDBImpl({required this.sitioEntregaLocalDataSource});

  @override
  Future<Either<Failure, List<SitioEntregaEntity>>>
      getSitiosEntregasRepositoryDB() async {
    try {
      final sitiosEntregasDB =
          await sitioEntregaLocalDataSource.getSitiosEntregasDB();

      return Right(sitiosEntregasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveSitiosEntregasRepositoryDB(
      List<SitioEntregaEntity> sitioEntregaEntity) async {
    try {
      final sitioEntregaDB = await sitioEntregaLocalDataSource
          .saveSitiosEntregas(sitioEntregaEntity);
      return Right(sitioEntregaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
