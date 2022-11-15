import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_precio_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionPrecioRepository {
  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilPreInversionPreciosRepository(UsuarioEntity usuario);
}
