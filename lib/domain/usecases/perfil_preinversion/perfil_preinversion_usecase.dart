import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_preinversion/perfil_preinversion_repository.dart';

class PerfilPreinversionUsecase {
  final PerfilPreinversionRepository repository;

  PerfilPreinversionUsecase(this.repository);

  Future<Either<Failure, List<PerfilPreinversionEntity>>>
      getPerfilesPreinversionUsecase(UsuarioEntity usuario) {
    return repository.getPerfilesPreinversionRepository(usuario);
  }
}
