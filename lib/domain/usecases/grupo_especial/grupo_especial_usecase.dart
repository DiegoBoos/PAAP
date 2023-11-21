import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/grupo_especial_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/grupo_especial/grupo_especial_repository.dart';

class GrupoEspecialUsecase {
  final GrupoEspecialRepository repository;

  GrupoEspecialUsecase(this.repository);

  Future<Either<Failure, List<GrupoEspecialEntity>>> getGruposEspecialesUsecase(
      UsuarioEntity usuario) {
    return repository.getGruposEspecialesRepository(usuario);
  }
}
