import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/frecuencia_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/frecuencia/frecuencia_repository.dart';

class FrecuenciaUsecase {
  final FrecuenciaRepository repository;

  FrecuenciaUsecase(this.repository);

  Future<Either<Failure, List<FrecuenciaEntity>>> getFrecuenciasUsecase(
      UsuarioEntity usuario) {
    return repository.getFrecuenciasRepository(usuario);
  }
}
