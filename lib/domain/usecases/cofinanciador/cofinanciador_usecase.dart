import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/cofinanciador_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/cofinanciador/cofinanciador_repository.dart';

class CofinanciadorUsecase {
  final CofinanciadorRepository repository;

  CofinanciadorUsecase(this.repository);

  Future<Either<Failure, List<CofinanciadorEntity>>>
      getCofinanciadoresByDepartamentoUsecase(UsuarioEntity usuario) {
    return repository.getCofinanciadoresByDepartamentoRepository(usuario);
  }
}
