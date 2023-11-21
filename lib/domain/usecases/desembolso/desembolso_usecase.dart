import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/desembolso_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/desembolso/desembolso_repository.dart';

class DesembolsoUsecase {
  final DesembolsoRepository repository;

  DesembolsoUsecase(this.repository);

  Future<Either<Failure, List<DesembolsoEntity>>> getDesembolsosUsecase(
      UsuarioEntity usuario) {
    return repository.getDesembolsosRepository(usuario);
  }
}
