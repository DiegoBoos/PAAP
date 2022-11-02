import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/agrupacion_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/agrupacion/agrupacion_repository.dart';

class AgrupacionUsecase {
  final AgrupacionRepository repository;

  AgrupacionUsecase(this.repository);

  Future<Either<Failure, List<AgrupacionEntity>>> getAgrupacionesUsecase(
      UsuarioEntity usuario) {
    return repository.getAgrupacionesRepository(usuario);
  }
}
