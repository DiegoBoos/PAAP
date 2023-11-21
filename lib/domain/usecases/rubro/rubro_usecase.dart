import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/rubro_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/rubro/rubro_repository.dart';

class RubroUsecase {
  final RubroRepository repository;

  RubroUsecase(this.repository);

  Future<Either<Failure, List<RubroEntity>>> getRubrosUsecase(
      UsuarioEntity usuario) {
    return repository.getRubrosRepository(usuario);
  }
}
