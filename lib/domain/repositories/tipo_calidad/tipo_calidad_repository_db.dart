import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_calidad_entity.dart';

abstract class TipoCalidadRepositoryDB {
  Future<Either<Failure, List<TipoCalidadEntity>>>
      getTiposCalidadesRepositoryDB();

  Future<Either<Failure, int>> saveTiposCalidadesRepositoryDB(
      List<TipoCalidadEntity> tipoCalidadEntity);
}
