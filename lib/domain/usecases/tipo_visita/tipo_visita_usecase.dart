import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_visita_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/tipo_visita/tipo_visita_repository.dart';

class TipoVisitaUsecase {
  final TipoVisitaRepository repository;

  TipoVisitaUsecase(this.repository);

  Future<Either<Failure, List<TipoVisitaEntity>>> getTiposVisitasUsecase(
      UsuarioEntity usuario) {
    return repository.getTiposVisitasRepository(usuario);
  }
}
