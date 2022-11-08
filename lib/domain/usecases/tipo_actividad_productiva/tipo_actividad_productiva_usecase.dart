import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_actividad_productiva_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/tipo_actividad_productiva/tipo_actividad_productiva_repository.dart';

class TipoActividadProductivaUsecase {
  final TipoActividadProductivaRepository repository;

  TipoActividadProductivaUsecase(this.repository);

  Future<Either<Failure, List<TipoActividadProductivaEntity>>>
      getTiposActividadesProductivasUsecase(UsuarioEntity usuario) {
    return repository.getTiposActividadesProductivasRepository(usuario);
  }
}
