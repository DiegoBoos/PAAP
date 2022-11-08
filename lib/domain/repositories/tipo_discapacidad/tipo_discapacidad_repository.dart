import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_discapacidad_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class TipoDiscapacidadRepository {
  Future<Either<Failure, List<TipoDiscapacidadEntity>>>
      getTiposDiscapacidadesRepository(UsuarioEntity usuario);
}
