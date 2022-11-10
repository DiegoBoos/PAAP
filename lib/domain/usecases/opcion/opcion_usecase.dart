import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/opcion_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/opcion/opcion_repository.dart';

class OpcionUsecase {
  final OpcionRepository repository;

  OpcionUsecase(this.repository);

  Future<Either<Failure, List<OpcionEntity>>> getOpcionesUsecase(
      UsuarioEntity usuario) {
    return repository.getOpcionesRepository(usuario);
  }
}
