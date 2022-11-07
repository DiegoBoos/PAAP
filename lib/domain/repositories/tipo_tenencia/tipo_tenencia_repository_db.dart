import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_tenencia_entity.dart';

abstract class TipoTenenciaRepositoryDB {
  Future<Either<Failure, List<TipoTenenciaEntity>>>
      getTiposTenenciasRepositoryDB();

  Future<Either<Failure, int>> saveTiposTenenciasRepositoryDB(
      List<TipoTenenciaEntity> tipotenenciaEntity);
}
