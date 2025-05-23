import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionCofinanciadorRepository {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilPreInversionCofinanciadoresRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      savePerfilesPreInversionesCofinanciadoresRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorEntity>
              perfilPreInversionCofinanciadorsEntity);
}
