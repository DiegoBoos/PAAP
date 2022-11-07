import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/vereda_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class VeredaRepository {
  Future<Either<Failure, List<VeredaEntity>>> getVeredasRepository(
      UsuarioEntity usuario);
}
