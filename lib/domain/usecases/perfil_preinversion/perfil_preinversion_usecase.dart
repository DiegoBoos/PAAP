import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion/perfil_preinversion_repository.dart';

class PerfilPreInversionUsecase {
  final PerfilPreInversionRepository repository;

  PerfilPreInversionUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreInversionEntity>>>
      getPerfilesPreInversionUsecase(UsuarioEntity usuario) {
    return repository.getPerfilesPreInversionRepository(usuario);
  }
}
