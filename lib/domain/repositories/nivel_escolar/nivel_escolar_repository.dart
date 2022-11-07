import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/nivel_escolar_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class NivelEscolarRepository {
  Future<Either<Failure, List<NivelEscolarEntity>>>
      getNivelesEscolaresRepository(UsuarioEntity usuario);
}
