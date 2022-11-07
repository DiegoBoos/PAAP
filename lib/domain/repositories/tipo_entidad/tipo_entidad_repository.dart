import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_entidad_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class TipoEntidadRepository {
  Future<Either<Failure, List<TipoEntidadEntity>>> getTiposEntidadesRepository(
      UsuarioEntity usuario);
}
