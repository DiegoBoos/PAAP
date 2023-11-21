import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_aliado_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_aliado/perfil_preinversion_aliado_repository.dart';

class PerfilPreInversionAliadoUsecase {
  final PerfilPreInversionAliadoRepository repository;

  PerfilPreInversionAliadoUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      getPerfilPreInversionAliadosUsecase(UsuarioEntity usuario) {
    return repository.getPerfilPreInversionAliadosRepository(usuario);
  }

  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      savePerfilesPreInversionesAliadosUsecase(UsuarioEntity usuario,
          List<PerfilPreInversionAliadoEntity> perfilPreInversionAliadoEntity) {
    return repository.savePerfilesPreInversionesAliadosRepository(
        usuario, perfilPreInversionAliadoEntity);
  }
}
