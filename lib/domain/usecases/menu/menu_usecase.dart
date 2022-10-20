import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';

import '../../core/error/failure.dart';
import '../../repositories/menu/menu_repository.dart';

class MenuUsecase {
  final MenuRepository repository;

  MenuUsecase(this.repository);

  Future<Either<Failure, List<MenuEntity>>> getMenuUsecase(
      String usuarioId, String contrasena) {
    return repository.getMenuRepository(usuarioId, contrasena);
  }
}
