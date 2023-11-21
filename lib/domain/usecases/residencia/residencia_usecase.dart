import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/residencia_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/residencia/residencia_repository.dart';

class ResidenciaUsecase {
  final ResidenciaRepository repository;

  ResidenciaUsecase(this.repository);

  Future<Either<Failure, List<ResidenciaEntity>>> getResidenciasUsecase(
      UsuarioEntity usuario) {
    return repository.getResidenciasRepository(usuario);
  }
}
