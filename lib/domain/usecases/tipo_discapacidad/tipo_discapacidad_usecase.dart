import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_discapacidad_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/tipo_discapacidad/tipo_discapacidad_repository.dart';

class TipoDiscapacidadUsecase {
  final TipoDiscapacidadRepository repository;

  TipoDiscapacidadUsecase(this.repository);

  Future<Either<Failure, List<TipoDiscapacidadEntity>>>
      getTiposDiscapacidadesUsecase(UsuarioEntity usuario) {
    return repository.getTiposDiscapacidadesRepository(usuario);
  }
}
