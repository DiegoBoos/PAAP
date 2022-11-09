import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/actividad_economica_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ActividadEconomicaRepository {
  Future<Either<Failure, List<ActividadEconomicaEntity>>>
      getActividadesEconomicasRepository(UsuarioEntity usuario);
}
