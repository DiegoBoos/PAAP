import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/sitio_entrega_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/sitio_entrega/sitio_entrega_repository.dart';

class SitioEntregaUsecase {
  final SitioEntregaRepository repository;

  SitioEntregaUsecase(this.repository);

  Future<Either<Failure, List<SitioEntregaEntity>>> getSitiosEntregasUsecase(
      UsuarioEntity usuario) {
    return repository.getSitiosEntregasRepository(usuario);
  }
}
