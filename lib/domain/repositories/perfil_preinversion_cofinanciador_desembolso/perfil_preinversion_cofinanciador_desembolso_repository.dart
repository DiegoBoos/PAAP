import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoRepository {
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilPreInversionCofinanciadorDesembolsosRepository(
          UsuarioEntity usuario);
}
