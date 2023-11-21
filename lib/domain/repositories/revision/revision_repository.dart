import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/revision_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class RevisionRepository {
  Future<Either<Failure, List<RevisionEntity>>> getRevisionesRepository(
      UsuarioEntity usuario);
}
