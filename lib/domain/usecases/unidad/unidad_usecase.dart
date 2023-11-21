import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/unidad_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/unidad/unidad_repository.dart';

class UnidadUsecase {
  final UnidadRepository repository;

  UnidadUsecase(this.repository);

  Future<Either<Failure, List<UnidadEntity>>> getUnidadesUsecase(
      UsuarioEntity usuario) {
    return repository.getUnidadesRepository(usuario);
  }
}
