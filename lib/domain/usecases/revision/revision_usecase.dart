import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/revision_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/revision/revision_repository.dart';

class RevisionUsecase {
  final RevisionRepository repository;

  RevisionUsecase(this.repository);

  Future<Either<Failure, List<RevisionEntity>>> getRevisionesUsecase(
      UsuarioEntity usuario) {
    return repository.getRevisionesRepository(usuario);
  }
}
