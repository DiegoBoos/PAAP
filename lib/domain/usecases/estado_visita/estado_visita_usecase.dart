import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/estado_visita_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/estado_visita/estado_visita_repository.dart';

class EstadoVisitaUsecase {
  final EstadoVisitaRepository repository;

  EstadoVisitaUsecase(this.repository);

  Future<Either<Failure, List<EstadoVisitaEntity>>> getEstadosVisitasUsecase(
      UsuarioEntity usuario) {
    return repository.getEstadosVisitasRepository(usuario);
  }
}
