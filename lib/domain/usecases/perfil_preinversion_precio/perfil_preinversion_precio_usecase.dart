import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_precio_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_precio/perfil_preinversion_precio_repository.dart';

class PerfilPreInversionPrecioUsecase {
  final PerfilPreInversionPrecioRepository repository;

  PerfilPreInversionPrecioUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilPreInversionPreciosUsecase(UsuarioEntity usuario) {
    return repository.getPerfilPreInversionPreciosRepository(usuario);
  }

  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      savePerfilesPreInversionesPreciosUsecase(UsuarioEntity usuario,
          List<PerfilPreInversionPrecioEntity> perfilPreInversionPrecioEntity) {
    return repository.savePerfilesPreInversionesPreciosRepository(
        usuario, perfilPreInversionPrecioEntity);
  }
}
