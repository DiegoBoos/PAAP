import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/nivel_escolar_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/nivel_escolar/nivel_escolar_repository.dart';

class NivelEscolarUsecase {
  final NivelEscolarRepository repository;

  NivelEscolarUsecase(this.repository);

  Future<Either<Failure, List<NivelEscolarEntity>>> getNivelesEscolaresUsecase(
      UsuarioEntity usuario) {
    return repository.getNivelesEscolaresRepository(usuario);
  }
}
