import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';

import '../../core/error/failure.dart';

abstract class MenuRepositoryDB {
  Future<Either<Failure, List<MenuEntity>>> getMenuRepositoryDB();

  Future<Either<Failure, int>> saveMenuRepositoryDB(
      List<MenuEntity> menuEntity);
}
