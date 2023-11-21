import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/grupo_especial_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class GrupoEspecialRepository {
  Future<Either<Failure, List<GrupoEspecialEntity>>>
      getGruposEspecialesRepository(UsuarioEntity usuario);
}
