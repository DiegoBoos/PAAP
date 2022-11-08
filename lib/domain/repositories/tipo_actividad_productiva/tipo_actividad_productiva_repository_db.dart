import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_actividad_productiva_entity.dart';

abstract class TipoActividadProductivaRepositoryDB {
  Future<Either<Failure, List<TipoActividadProductivaEntity>>>
      getTiposActividadesProductivasRepositoryDB();

  Future<Either<Failure, int>> saveTiposActividadesProductivasRepositoryDB(
      List<TipoActividadProductivaEntity> tipoActividadProductivaEntity);
}
