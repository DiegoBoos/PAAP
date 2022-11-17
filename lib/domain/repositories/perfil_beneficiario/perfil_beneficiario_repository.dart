import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_beneficiario_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilBeneficiarioRepository {
  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilBeneficiariosRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      savePerfilesBeneficiariosRepository(UsuarioEntity usuario,
          List<PerfilBeneficiarioEntity> perfilesBeneficiariosEntity);
}
