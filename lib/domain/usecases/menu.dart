import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';

import '../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class Menu {
  final AuthRepository repository;

  Menu(this.repository);

  Future<Either<Failure, List<MenuEntity>>> getMenu(
      String usuarioId, String contrasena) {
    return repository.getMenu(usuarioId, contrasena);
  }
}
