import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/aliado_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class AliadoRepository {
  Future<Either<Failure, List<AliadoEntity>>> getAliadosRepository(
      UsuarioEntity usuario);
}
