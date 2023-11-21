import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/tipo_calidad_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class TipoCalidadRepository {
  Future<Either<Failure, List<TipoCalidadEntity>>> getTiposCalidadesRepository(
      UsuarioEntity usuario);
}
