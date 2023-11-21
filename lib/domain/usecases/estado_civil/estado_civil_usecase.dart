import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/estado_civil_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/estado_civil/estado_civil_repository.dart';

class EstadoCivilUsecase {
  final EstadoCivilRepository repository;

  EstadoCivilUsecase(this.repository);

  Future<Either<Failure, List<EstadoCivilEntity>>> getEstadosCivilesUsecase(
      UsuarioEntity usuario) {
    return repository.getEstadosCivilesRepository(usuario);
  }
}
