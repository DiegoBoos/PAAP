import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/menu_entity.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/repositories/menu/menu_repository.dart';
import '../../datasources/remote/menu/menu_remote_ds.dart';
import '../../models/menu_model.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource menuRemoteDataSource;

  MenuRepositoryImpl({required this.menuRemoteDataSource});

  @override
  Future<Either<Failure, List<MenuEntity>>> getMenuRepository(
      String usuarioId, String contrasena) async {
    try {
      final result = await menuRemoteDataSource.getMenu(usuarioId, contrasena);

      final menuRawList = result.entries.first.value['Table'];
      final menuList =
          List.from(menuRawList).map((e) => MenuModel.fromJson(e)).toList();

      return Right(menuList);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
