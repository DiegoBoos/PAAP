import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/menu_entity.dart';
import '../../repositories/menu/menu_repository_db.dart';

class MenuUsecaseDB {
  final MenuRepositoryDB repositoryDB;

  MenuUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<MenuEntity>?>> getMenuUsecaseDB() {
    return repositoryDB.getMenuRepositoryDB();
  }

  Future<Either<Failure, MenuEntity>> saveMenuUsecaseDB(MenuEntity menuEntity) {
    return repositoryDB.saveMenuRepositoryDB(menuEntity);
  }
}
