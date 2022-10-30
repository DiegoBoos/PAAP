import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/menu_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/menu/menu_repository.dart';

class MenuUsecase {
  final MenuRepository repository;

  MenuUsecase(this.repository);

  Future<Either<Failure, List<MenuEntity>>> getMenuUsecase(
      UsuarioEntity usuario) {
    return repository.getMenuRepository(usuario);
  }
}
