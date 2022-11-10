import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/visita_entity.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/visita/visita_repository.dart';

class VisitaUsecase {
  final VisitaRepository repository;

  VisitaUsecase(this.repository);

  Future<Either<Failure, int>> saveVisitaUsecase(
      UsuarioEntity usuario, VisitaEntity visitaEntity) {
    return repository.saveVisitaRepository(usuario, visitaEntity);
  }
}
