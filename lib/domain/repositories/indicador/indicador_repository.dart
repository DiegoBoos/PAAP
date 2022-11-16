import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/indicador_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class IndicadorRepository {
  Future<Either<Failure, List<IndicadorEntity>>> getIndicadoresRepository(
      UsuarioEntity usuario);
}
