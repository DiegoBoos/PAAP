import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/objetivo_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/objetivo/objetivo_repository.dart';

class ObjetivoUsecase {
  final ObjetivoRepository repository;

  ObjetivoUsecase(this.repository);

  Future<Either<Failure, List<ObjetivoEntity>>> getObjetivosUsecase(
      UsuarioEntity usuario) {
    return repository.getObjetivosRepository(usuario);
  }
}
