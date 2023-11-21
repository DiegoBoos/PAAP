import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/perfil_beneficiario_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_beneficiario/perfil_beneficiario_repository.dart';

class PerfilBeneficiarioUsecase {
  final PerfilBeneficiarioRepository repository;

  PerfilBeneficiarioUsecase(this.repository);

  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      getPerfilBeneficiariosUsecase(UsuarioEntity usuario) {
    return repository.getPerfilBeneficiariosRepository(usuario);
  }

  Future<Either<Failure, List<PerfilBeneficiarioEntity>>>
      savePerfilesBeneficiariosUsecase(UsuarioEntity usuario,
          List<PerfilBeneficiarioEntity> perfilBeneficiarioEntity) {
    return repository.savePerfilesBeneficiariosRepository(
        usuario, perfilBeneficiarioEntity);
  }
}
