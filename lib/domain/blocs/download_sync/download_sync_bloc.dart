import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/convocatoria_entity.dart';
import '../../entities/menu_entity.dart';
import '../../entities/perfil_entity.dart';
import '../../entities/tipo_proyecto_entity.dart';
import '../../entities/unidad_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../entities/producto_entity.dart';
import '../../usecases/convocatoria/convocatoria_exports.dart';
import '../../usecases/menu/menu_exports.dart';
import '../../usecases/perfiles/perfiles_exports.dart';
import '../../usecases/tipo_proyecto/tipo_proyecto_exports.dart';
import '../../usecases/unidad/unidad_exports.dart';
import '../../usecases/producto/producto_exports.dart';

part 'download_sync_event.dart';
part 'download_sync_state.dart';

class DownloadSyncBloc extends Bloc<DownloadSyncEvent, DownloadSyncState> {
  String title = '';
  int counter = 0;
  double progress = 0;

  final MenuUsecase menu;
  final MenuUsecaseDB menuDB;
  List<MenuEntity> menus = [];
  bool menuDownloaded = false;

  final ConvocatoriaUsecase convocatoria;
  final ConvocatoriaUsecaseDB convocatoriaDB;
  List<ConvocatoriaEntity> convocatorias = [];
  bool convocatoriasDownloaded = false;

  final TipoProyectoUsecase tipoProyecto;
  final TipoProyectoUsecaseDB tipoProyectoDB;

  final UnidadUsecase unidad;
  final UnidadUsecaseDB unidadDB;

  final PerfilesUsecase perfiles;
  final PerfilesUsecaseDB perfilesDB;

  final ProductoUsecase productos;
  final ProductoUsecaseDB productosDB;

  DownloadSyncBloc({
    required this.menu,
    required this.menuDB,
    required this.convocatoria,
    required this.convocatoriaDB,
    required this.tipoProyecto,
    required this.tipoProyectoDB,
    required this.unidad,
    required this.unidadDB,
    required this.perfiles,
    required this.perfilesDB,
    required this.productos,
    required this.productosDB,
  }) : super(DownloadSyncInitial()) {
    listenDownloadStates();
    on<DownloadStarted>((event, emit) async {
      final usuario = event.usuario;
      emit(DownloadSyncInProgress());
      downloadMenu(usuario, emit);
      //downloadConvocatorias(usuario, emit);
      //downloadTiposProyectos(usuario, emit);
      //downloadUnidades(usuario, emit);
      //downloadPerfiles(usuario, emit);
      //downloadProductos(usuario, emit);
    });

    on<DownloadStatusChanged>((event, emit) {
      emit(DownloadSyncInProgress(
          title: event.title,
          counter: event.counter,
          progress: event.progress));
    });

    on<DownloadSyncCompleted>((_, emit) => emit(DownloadSyncSuccess()));

    on<MenuDownloaded>((_, emit) => emit(MenuDownloadSyncSuccess()));

    on<ConvocatoriasDownloaded>(
        (_, emit) => emit(ConvocatoriasDownloadSyncSuccess()));
  }

  StreamSubscription<DownloadSyncState> listenDownloadStates() {
    return stream.listen((state) {
      if (state is MenuDownloadSyncSuccess) menuDownloaded = true;
      if (state is ConvocatoriasDownloadSyncSuccess) {
        convocatoriasDownloaded = true;
      }
      if (menuDownloaded && convocatoriasDownloaded) {
        add(DownloadSyncCompleted());
      }
    });
  }

  void downloadMenu(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await menu.getMenuUsecase(usuario);
    result
        .fold((failure) => emit(DownloadSyncFailure(failure.properties.first)),
            (data) {
      menus = data;
    });
  }

  insertMenu(MenuEntity menuEntity, Emitter<DownloadSyncState> emit) async {
    final result = await menuDB.saveMenuUsecaseDB(menuEntity);
    result
        .fold((failure) => emit(DownloadSyncFailure(failure.properties.first)),
            (data) {
      title = 'Descargando menus... $counter';
      counter += 1;
      progress = ((counter / menus.length) * 100) / 100;

      if (counter >= menus.length) {
        title = '';
        counter = 0;
        progress = 0.0;
        add(MenuDownloaded());
        return;
      }

      add(DownloadStatusChanged(
          title: title, counter: counter, progress: progress));

      MenuEntity menu = menus[counter];
      insertMenu(menu, emit);
    });
  }

  void downloadConvocatorias(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await convocatoria.getConvocatoriasUsecase(usuario);
    return result
        .fold((failure) => emit(DownloadSyncFailure(failure.properties.first)),
            (data) {
      convocatorias = data;
    });
  }

  insertConvocatoria(ConvocatoriaEntity convocatoriaEntity,
      Emitter<DownloadSyncState> emit) async {
    final result =
        await convocatoriaDB.saveConvocatoriaUsecaseDB(convocatoriaEntity);
    result
        .fold((failure) => emit(DownloadSyncFailure(failure.properties.first)),
            (data) {
      title = 'Descargando convocatorias... $counter';
      counter += 1;
      progress = ((counter / convocatorias.length) * 100) / 100;

      if (counter >= convocatorias.length) {
        title = '';
        counter = 0;
        progress = 0.0;
        add(ConvocatoriasDownloaded());
        return;
      }

      add(DownloadStatusChanged(
          title: title, counter: counter, progress: progress));

      ConvocatoriaEntity convocatoria = convocatorias[counter];
      insertConvocatoria(convocatoria, emit);
    });
  }

  void downloadTiposProyectos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoProyecto.getTiposProyectosUsecase(usuario);
    return result
        .fold((failure) => emit(DownloadSyncFailure(failure.properties.first)),
            (data) {
      saveTiposProyectos(data, emit);
    });
  }

  void saveTiposProyectos(
      List<TipoProyectoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await tipoProyectoDB.saveTiposProyectosUsecaseDB(data);
    return result.fold(
        (failure) => emit(DownloadSyncFailure(failure.properties.first)), (_) {
      //getTiposProyectosDB();
    });
  }

  void downloadUnidades(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await unidad.getUnidadesUsecase(usuario);
    return result
        .fold((failure) => emit(DownloadSyncFailure(failure.properties.first)),
            (data) {
      saveUnidades(data, emit);
    });
  }

  void saveUnidades(
      List<UnidadEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await unidadDB.saveUnidadesUsecaseDB(data);
    return result.fold(
        (failure) => emit(DownloadSyncFailure(failure.properties.first)), (_) {
      //getUnidadesDB();
    });
  }

  void downloadPerfiles(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfiles.getPerfilesUsecase(usuario);
    return result
        .fold((failure) => emit(DownloadSyncFailure(failure.properties.first)),
            (data) {
      savePerfiles(data, emit);
    });
  }

  void savePerfiles(
      List<PerfilEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await perfilesDB.savePerfilesUsecaseDB(data);
    return result.fold(
        (failure) => emit(DownloadSyncFailure(failure.properties.first)), (_) {
      //getPerfilesDB();
    });
  }

  void downloadProductos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await productos.getProductosUsecase(usuario);
    return result
        .fold((failure) => emit(DownloadSyncFailure(failure.properties.first)),
            (data) {
      saveProductos(data, emit);
    });
  }

  void saveProductos(
      List<ProductoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await productosDB.saveProductoUsecaseDB(data);
    return result.fold(
        (failure) => emit(DownloadSyncFailure(failure.properties.first)), (_) {
      //getPerfilesDB();
    });
  }

  List<MenuEntity> preinversionMenuSorted(List<MenuEntity> menu) {
    final preinversionMenu = menu
        .where((menu) =>
            menu.menuId == '36' ||
            menu.menuId == '37' ||
            menu.menuId == '38' ||
            menu.menuId == '39' ||
            menu.menuId == '40' ||
            menu.menuId == '41' ||
            menu.menuId == '2067')
        .toList();
    preinversionMenu.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });
    return preinversionMenu;
  }

  List<MenuEntity> alianzasMenuSorted(List<MenuEntity> menu) {
    final alianzasMenu = menu
        .where((menu) =>
            menu.menuId == '11' || menu.menuId == '43' || menu.menuId == '44')
        .toList();
    alianzasMenu.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });
    return alianzasMenu;
  }

  /*Future<Either<Failure, List<ConvocatoriaEntity>?>>
      getConvocatoriasDB() async {
    final result = await convocatoriaDB.getConvocatoriasUsecaseDB();
    return result.fold(
        (failure) => Left(failure.properties.first), (data) => Right(data));
  }

  Future<Either<Failure, List<TipoProyectoEntity>?>>
      getTiposProyectosDB() async {
    final result = await tipoProyectoDB.getTiposProyectosUsecaseDB();
    return result.fold(
        (failure) => Left(failure.properties.first), (data) => Right(data));
  }

  Future<Either<Failure, List<UnidadEntity>?>> getUnidadesDB() async {
    final result = await unidadDB.getUnidadesUsecaseDB();
    return result.fold(
        (failure) => Left(failure.properties.first), (data) => Right(data));
  }

  Future<Either<Failure, List<PerfilEntity>?>> getPerfilesDB() async {
    final result = await perfilesDB.getPerfilesUsecaseDB();
    return result.fold(
        (failure) => Left(failure.properties.first), (data) => Right(data));
  }*/
}
