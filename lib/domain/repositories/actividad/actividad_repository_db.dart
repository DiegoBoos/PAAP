import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/actividad_entity.dart';

abstract class ActividadRepositoryDB {
  Future<Either<Failure, List<ActividadEntity>>> getActividadesRepositoryDB();
  Future<Either<Failure, ActividadEntity?>> getActividadRepositoryDB(String id);

  Future<Either<Failure, int>> saveActividadesRepositoryDB(
      List<ActividadEntity> actividadEntity);
}
