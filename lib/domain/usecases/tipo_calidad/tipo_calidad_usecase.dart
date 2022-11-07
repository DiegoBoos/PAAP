import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_calidad_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/tipo_calidad/tipo_calidad_repository.dart';

class TipoCalidadUsecase {
  final TipoCalidadRepository repository;

  TipoCalidadUsecase(this.repository);

  Future<Either<Failure, List<TipoCalidadEntity>>> getTiposCalidadesUsecase(
      UsuarioEntity usuario) {
    return repository.getTiposCalidadesRepository(usuario);
  }
}
