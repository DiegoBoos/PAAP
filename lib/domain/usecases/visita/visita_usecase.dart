import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/visita_entity.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/visita/visita_repository.dart';

class VisitaUsecase {
  final VisitaRepository repository;

  VisitaUsecase(this.repository);

  Future<Either<Failure, List<VisitaEntity>>> getVisitasUsecase(
      UsuarioEntity usuario) {
    return repository.getVisitasRepository(usuario);
  }

  Future<Either<Failure, List<VisitaEntity>>> saveVisitasUsecase(
      UsuarioEntity usuario, List<VisitaEntity> visitaEntity) {
    return repository.saveVisitasRepository(usuario, visitaEntity);
  }
}
