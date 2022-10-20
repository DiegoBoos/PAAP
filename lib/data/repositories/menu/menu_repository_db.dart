import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/repositories/menu/menu_repository_db.dart';
import '../../datasources/local/menu/menu_local_ds.dart';

class MenuRepositoryDBImpl implements MenuRepositoryDB {
  final MenuLocalDataSource menuLocalDataSource;

  MenuRepositoryDBImpl({required this.menuLocalDataSource});

  @override
  Future<Either<Failure, List<MenuEntity>>> getMenuRepositoryDB() async {
    try {
      final menuDB = await menuLocalDataSource.getMenuDB();
      final menuList =
          List<MenuEntity>.from(menuDB.map((m) => MenuEntity.fromJson(m)));

      return Right(menuList);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveMenuRepositoryDB(
      List<MenuEntity> menuEntity) async {
    try {
      final menuDB = await menuLocalDataSource.saveMenu(menuEntity);
      return Right(menuDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
