import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/menu_entity.dart';

abstract class MenuRepositoryDB {
  Future<Either<Failure, List<MenuEntity>>> getMenuRepositoryDB();

  Future<Either<Failure, MenuEntity>> saveMenuRepositoryDB(
      MenuEntity menuEntity);
}
