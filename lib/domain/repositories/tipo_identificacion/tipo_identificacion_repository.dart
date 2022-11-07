import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_identificacion_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class TipoIdentificacionRepository {
  Future<Either<Failure, List<TipoIdentificacionEntity>>>
      getTiposIdentificacionesRepository(UsuarioEntity usuario);
}
