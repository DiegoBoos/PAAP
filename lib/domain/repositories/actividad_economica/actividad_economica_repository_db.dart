import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/actividad_economica_entity.dart';

abstract class ActividadEconomicaRepositoryDB {
  Future<Either<Failure, List<ActividadEconomicaEntity>>>
      getActividadesEconomicasRepositoryDB();

  Future<Either<Failure, int>> saveActividadesEconomicasRepositoryDB(
      List<ActividadEconomicaEntity> actividadEconomicaEntity);
}
