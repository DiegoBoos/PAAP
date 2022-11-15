import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_repository.dart';

class PerfilPreInversionCofinanciadorDesembolsoUsecase {
  final PerfilPreInversionCofinanciadorDesembolsoRepository repository;

  PerfilPreInversionCofinanciadorDesembolsoUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilPreInversionCofinanciadorDesembolsosUsecase(
          UsuarioEntity usuario) {
    return repository
        .getPerfilPreInversionCofinanciadorDesembolsosRepository(usuario);
  }
}
