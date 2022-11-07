import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_entidad_entity.dart';

abstract class TipoEntidadRepositoryDB {
  Future<Either<Failure, List<TipoEntidadEntity>>>
      getTiposEntidadesRepositoryDB();

  Future<Either<Failure, int>> saveTiposEntidadesRepositoryDB(
      List<TipoEntidadEntity> tipoentidadEntity);
}
