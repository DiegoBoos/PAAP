import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';

import '../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class MenuDB {
  final AuthRepository repository;

  MenuDB(this.repository);

  Future<Either<Failure, List<MenuEntity>>> getMenuDB() {
    return repository.getMenuDB();
  }
}
