import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_consultor_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_consultor/perfil_preinversion_consultor_repository.dart';

class PerfilPreInversionConsultorUsecase {
  final PerfilPreInversionConsultorRepository repository;

  PerfilPreInversionConsultorUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      getPerfilPreInversionConsultoresUsecase(UsuarioEntity usuario) {
    return repository.getPerfilPreInversionConsultoresRepository(usuario);
  }

  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      savePerfilesPreInversionesConsultoresUsecase(
          UsuarioEntity usuario,
          List<PerfilPreInversionConsultorEntity>
              perfilPreInversionConsultorEntity) {
    return repository.savePerfilesPreInversionesConsultoresRepository(
        usuario, perfilPreInversionConsultorEntity);
  }
}
