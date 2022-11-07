import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/aliado_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/aliado/aliado_repository.dart';

class AliadoUsecase {
  final AliadoRepository repository;

  AliadoUsecase(this.repository);

  Future<Either<Failure, List<AliadoEntity>>> getAliadosUsecase(
      UsuarioEntity usuario) {
    return repository.getAliadosRepository(usuario);
  }
}
