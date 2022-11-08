import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/tipo_actividad_productiva_entity.dart';
import '../../repositories/tipo_actividad_productiva/tipo_actividad_productiva_repository_db.dart';

class TipoActividadProductivaUsecaseDB {
  final TipoActividadProductivaRepositoryDB repositoryDB;

  TipoActividadProductivaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<TipoActividadProductivaEntity>?>>
      getTiposActividadesProductivasUsecaseDB() {
    return repositoryDB.getTiposActividadesProductivasRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposActividadesProductivasUsecaseDB(
      List<TipoActividadProductivaEntity> tipoActividadProductivaEntity) {
    return repositoryDB.saveTiposActividadesProductivasRepositoryDB(
        tipoActividadProductivaEntity);
  }
}
