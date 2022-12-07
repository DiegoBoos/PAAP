import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/cofinanciador_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class CofinanciadorRepository {
  Future<Either<Failure, List<CofinanciadorEntity>>>
      getCofinanciadoresByDepartamentoRepository(UsuarioEntity usuario);
}
