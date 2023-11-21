import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/tipo_actividad_productiva_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class TipoActividadProductivaRepository {
  Future<Either<Failure, List<TipoActividadProductivaEntity>>>
      getTiposActividadesProductivasRepository(UsuarioEntity usuario);
}
