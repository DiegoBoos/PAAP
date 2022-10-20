import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';

import '../../core/error/failure.dart';

abstract class MenuRepository {
  Future<Either<Failure, List<MenuEntity>>> getMenuRepository(
      String usuarioId, String contrasena);
}
