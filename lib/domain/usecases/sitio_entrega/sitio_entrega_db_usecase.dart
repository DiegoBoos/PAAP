import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/sitio_entrega_entity.dart';
import '../../repositories/sitio_entrega/sitio_entrega_repository_db.dart';

class SitioEntregaUsecaseDB {
  final SitioEntregaRepositoryDB repositoryDB;

  SitioEntregaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<SitioEntregaEntity>?>>
      getSitiosEntregasUsecaseDB() {
    return repositoryDB.getSitiosEntregasRepositoryDB();
  }

  Future<Either<Failure, int>> saveSitiosEntregasUsecaseDB(
      List<SitioEntregaEntity> sitiosEntregasEntity) {
    return repositoryDB.saveSitiosEntregasRepositoryDB(sitiosEntregasEntity);
  }
}
