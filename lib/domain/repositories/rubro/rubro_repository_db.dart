import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/rubro_entity.dart';

abstract class RubroRepositoryDB {
  Future<Either<Failure, List<RubroEntity>>> getRubrosRepositoryDB();

  Future<Either<Failure, int>> saveRubrosRepositoryDB(
      List<RubroEntity> rubroEntity);
}
