import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';
import '../../core/error/failure.dart';
import '../../repositories/menu/menu_repository_db.dart';

class MenuUsecaseDB {
  final MenuRepositoryDB repositoryDB;

  MenuUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<MenuEntity>?>> getMenuUsecaseDB() {
    return repositoryDB.getMenuRepositoryDB();
  }

  Future<Either<Failure, int>> saveMenuUsecaseDB(List<MenuEntity> menuEntity) {
    return repositoryDB.saveMenuRepositoryDB(menuEntity);
  }
}
