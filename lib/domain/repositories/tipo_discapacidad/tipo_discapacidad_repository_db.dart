import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_discapacidad_entity.dart';

abstract class TipoDiscapacidadRepositoryDB {
  Future<Either<Failure, List<TipoDiscapacidadEntity>>>
      getTiposDiscapacidadesRepositoryDB();

  Future<Either<Failure, int>> saveTiposDiscapacidadesRepositoryDB(
      List<TipoDiscapacidadEntity> tipoDiscapacidadEntity);
}
