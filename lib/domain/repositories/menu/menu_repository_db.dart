import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/menu_entity.dart';

abstract class MenuRepositoryDB {
  Future<Either<Failure, List<MenuEntity>>> getMenuRepositoryDB();

  Future<Either<Failure, int>> saveMenuRepositoryDB(
      List<MenuEntity> menuEntity);

  Future<Either<Failure, int>> verificacionDatosLocalesRepositoryDB();
}
