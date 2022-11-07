import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/actividad_financiera_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/actividad_financiera/actividad_financiera_repository.dart';

class ActividadFinancieraUsecase {
  final ActividadFinancieraRepository repository;

  ActividadFinancieraUsecase(this.repository);

  Future<Either<Failure, List<ActividadFinancieraEntity>>>
      getActividadesFinancierasUsecase(UsuarioEntity usuario) {
    return repository.getActividadesFinancierasRepository(usuario);
  }
}
