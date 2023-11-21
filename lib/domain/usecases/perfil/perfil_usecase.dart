import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/perfil_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil/perfil_repository.dart';

class PerfilUsecase {
  final PerfilRepository repository;

  PerfilUsecase(this.repository);

  Future<Either<Failure, List<PerfilEntity>>> getPerfilesUsecase(
      UsuarioEntity usuario) {
    return repository.getPerfilesRepository(usuario);
  }
}
