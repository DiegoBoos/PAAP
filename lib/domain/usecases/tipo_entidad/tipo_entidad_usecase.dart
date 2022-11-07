import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_entidad_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/tipo_entidad/tipo_entidad_repository.dart';

class TipoEntidadUsecase {
  final TipoEntidadRepository repository;

  TipoEntidadUsecase(this.repository);

  Future<Either<Failure, List<TipoEntidadEntity>>> getTiposEntidadesUsecase(
      UsuarioEntity usuario) {
    return repository.getTiposEntidadesRepository(usuario);
  }
}
