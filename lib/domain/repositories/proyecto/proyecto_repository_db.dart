import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/proyecto_entity.dart';

abstract class ProyectoRepositoryDB {
  Future<Either<Failure, List<ProyectoEntity>>> getProyectosRepositoryDB();

  Future<Either<Failure, int>> saveProyectosRepositoryDB(
      List<ProyectoEntity> proyectoEntity);
}
