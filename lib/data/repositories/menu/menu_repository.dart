import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/menu_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/menu/menu_repository.dart';
import '../../datasources/remote/menu_remote_ds.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource menuRemoteDataSource;

  MenuRepositoryImpl({required this.menuRemoteDataSource});

  @override
  Future<Either<Failure, List<MenuEntity>>> getMenuRepository(
      UsuarioEntity usuario) async {
    try {
      final menus = await menuRemoteDataSource.getMenu(usuario);

      return Right(menus);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
