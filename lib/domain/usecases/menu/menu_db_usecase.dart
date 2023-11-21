import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/menu_entity.dart';
import '../../repositories/menu/menu_repository_db.dart';

class MenuUsecaseDB {
  final MenuRepositoryDB repositoryDB;

  MenuUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<MenuEntity>?>> getMenuUsecaseDB() {
    return repositoryDB.getMenuRepositoryDB();
  }

  Future<Either<Failure, int>> saveMenuUsecaseDB(List<MenuEntity> menu) {
    return repositoryDB.saveMenuRepositoryDB(menu);
  }

  Future<Either<Failure, int>> verificacionDatosLocalesUsecaseDB() {
    return repositoryDB.verificacionDatosLocalesRepositoryDB();
  }
}
