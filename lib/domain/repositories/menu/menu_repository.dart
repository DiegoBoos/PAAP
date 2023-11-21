import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/menu_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class MenuRepository {
  Future<Either<Failure, List<MenuEntity>>> getMenuRepository(
      UsuarioEntity usuario);
}
