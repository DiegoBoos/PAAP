import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_repository.dart';

class PerfilPreInversionCofinanciadorUsecase {
  final PerfilPreInversionCofinanciadorRepository repository;

  PerfilPreInversionCofinanciadorUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilPreInversionCofinanciadoresUsecase(UsuarioEntity usuario) {
    return repository.getPerfilPreInversionCofinanciadoresRepository(usuario);
  }

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      savePerfilesPreInversionesCofinanciadoresUsecase(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorEntity>
              perfilPreInversionCofinanciadorEntity) {
    return repository.savePerfilesPreInversionesCofinanciadoresRepository(
        usuario, perfilPreInversionCofinanciadorEntity);
  }
}
