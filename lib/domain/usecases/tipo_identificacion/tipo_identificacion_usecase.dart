import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/tipo_identificacion_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/tipo_identificacion/tipo_identificacion_repository.dart';

class TipoIdentificacionUsecase {
  final TipoIdentificacionRepository repository;

  TipoIdentificacionUsecase(this.repository);

  Future<Either<Failure, List<TipoIdentificacionEntity>>>
      getTiposIdentificacionesUsecase(UsuarioEntity usuario) {
    return repository.getTiposIdentificacionesRepository(usuario);
  }
}
