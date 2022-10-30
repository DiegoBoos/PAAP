import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_proyecto_entity.dart';

abstract class TipoProyectoRepositoryDB {
  Future<Either<Failure, List<TipoProyectoEntity>>>
      getTiposProyectosRepositoryDB();

  Future<Either<Failure, int>> saveTiposProyectosRepositoryDB(
      List<TipoProyectoEntity> tipoproyectoEntity);
}
