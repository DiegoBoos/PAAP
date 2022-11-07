import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/actividad_financiera_entity.dart';

abstract class ActividadFinancieraRepositoryDB {
  Future<Either<Failure, List<ActividadFinancieraEntity>>>
      getActividadesFinancierasRepositoryDB();

  Future<Either<Failure, int>> saveActividadesFinancierasRepositoryDB(
      List<ActividadFinancieraEntity> actividadFinancieraEntity);
}
