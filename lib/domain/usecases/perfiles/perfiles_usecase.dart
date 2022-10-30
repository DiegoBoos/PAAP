import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../entities/vperfil_entity.dart';
import '../../repositories/perfiles/perfiles_repository.dart';

class PerfilesUsecase {
  final PerfilesRepository repository;

  PerfilesUsecase(this.repository);

  Future<Either<Failure, List<PerfilEntity>>> getPerfilesUsecase(
      UsuarioEntity usuario) {
    return repository.getPerfilesRepository(usuario);
  }

  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosUsecase(
      UsuarioEntity usuario, String? id, String? nombre) {
    return repository.getPerfilesFiltrosRepository(
        usuario, id ?? '', nombre ?? '');
  }

  Future<Either<Failure, VPerfilEntity>> getPerfilUsecase(
      UsuarioEntity usuario, String perfilId) {
    return repository.getPerfilRepository(usuario, perfilId);
  }
}
