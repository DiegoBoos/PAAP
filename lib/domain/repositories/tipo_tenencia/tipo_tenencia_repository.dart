import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/tipo_tenencia_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class TipoTenenciaRepository {
  Future<Either<Failure, List<TipoTenenciaEntity>>> getTiposTenenciasRepository(
      UsuarioEntity usuario);
}
