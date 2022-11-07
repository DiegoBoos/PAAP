import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/alianza_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class AlianzaRepository {
  Future<Either<Failure, List<AlianzaEntity>>> getAlianzasRepository(
      UsuarioEntity usuario);
}
