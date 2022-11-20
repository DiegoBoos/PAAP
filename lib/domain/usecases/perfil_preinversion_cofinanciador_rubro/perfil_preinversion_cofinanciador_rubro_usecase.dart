import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_repository.dart';

class PerfilPreInversionCofinanciadorRubroUsecase {
  final PerfilPreInversionCofinanciadorRubroRepository repository;

  PerfilPreInversionCofinanciadorRubroUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilPreInversionCofinanciadorRubrosUsecase(UsuarioEntity usuario) {
    return repository
        .getPerfilPreInversionCofinanciadorRubrosRepository(usuario);
  }

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      savePerfilesPreInversionesCofinanciadoresRubrosUsecase(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilPreInversionCofinanciadorRubroEntity) {
    return repository.savePerfilesPreInversionesCofinanciadoresRubrosRepository(
        usuario, perfilPreInversionCofinanciadorRubroEntity);
  }
}
