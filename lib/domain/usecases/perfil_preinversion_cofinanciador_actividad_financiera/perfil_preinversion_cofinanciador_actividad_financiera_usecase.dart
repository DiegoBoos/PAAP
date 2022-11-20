import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_repository.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraUsecase {
  final PerfilPreInversionCofinanciadorActividadFinancieraRepository repository;

  PerfilPreInversionCofinanciadorActividadFinancieraUsecase(this.repository);

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasUsecase(
          UsuarioEntity usuario) {
    return repository
        .getPerfilPreInversionCofinanciadorActividadesFinancierasRepository(
            usuario);
  }

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      savePerfilesPreInversionesCofinanciadoresActividadesFinancierasUsecase(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilPreInversionCofinanciadorActividadFinancieraEntity) {
    return repository
        .savePerfilesPreInversionesCofinanciadoresActividadesFinancierasRepository(
            usuario, perfilPreInversionCofinanciadorActividadFinancieraEntity);
  }
}
