import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/actividad_economica_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/actividad_economica/actividad_economica_repository.dart';

class ActividadEconomicaUsecase {
  final ActividadEconomicaRepository repository;

  ActividadEconomicaUsecase(this.repository);

  Future<Either<Failure, List<ActividadEconomicaEntity>>>
      getActividadesEconomicasUsecase(UsuarioEntity usuario) {
    return repository.getActividadesEconomicasRepository(usuario);
  }
}
