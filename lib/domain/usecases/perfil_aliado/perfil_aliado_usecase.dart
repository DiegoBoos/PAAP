import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/perfil_aliado_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/perfil_aliado/perfil_aliado_repository.dart';

class PerfilAliadoUsecase {
  final PerfilAliadoRepository repository;

  PerfilAliadoUsecase(this.repository);

  Future<Either<Failure, List<PerfilAliadoEntity>>> getPerfilAliadosUsecase(
      UsuarioEntity usuario) {
    return repository.getPerfilAliadosRepository(usuario);
  }

  Future<Either<Failure, List<PerfilAliadoEntity>>> savePerfilesAliadosUsecase(
      UsuarioEntity usuario, List<PerfilAliadoEntity> perfilAliadoEntity) {
    return repository.savePerfilesAliadosRepository(
        usuario, perfilAliadoEntity);
  }
}
