import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/actividad_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/actividad/actividad_repository.dart';

class ActividadUsecase {
  final ActividadRepository repository;

  ActividadUsecase(this.repository);

  Future<Either<Failure, List<ActividadEntity>>> getActividadesUsecase(
      UsuarioEntity usuario) {
    return repository.getActividadesRepository(usuario);
  }
}
