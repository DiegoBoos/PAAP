import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/criterio_entity.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/criterio/criterio_repository.dart';

class CriterioUsecase {
  final CriterioRepository repository;

  CriterioUsecase(this.repository);

  Future<Either<Failure, List<CriterioEntity>>> getCriteriosUsecase(
      UsuarioEntity usuario) {
    return repository.getCriteriosRepository(usuario);
  }
}
