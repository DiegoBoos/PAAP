import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_consultor_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionConsultorRepository {
  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      getPerfilPreInversionConsultoresRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      savePerfilesPreInversionesConsultoresRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionConsultorEntity>
              perfilPreInversionConsultorEntity);
}
