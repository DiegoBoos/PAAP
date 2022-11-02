import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/agrupacion_entity.dart';
import '../../entities/convocatoria_entity.dart';
import '../../entities/departamento_entity.dart';
import '../../entities/estado_visita_entity.dart';
import '../../entities/genero_entity.dart';
import '../../entities/menu_entity.dart';
import '../../entities/municipio_entity.dart';
import '../../entities/perfil_entity.dart';
import '../../entities/tipo_proyecto_entity.dart';
import '../../entities/tipo_visita_entity.dart';
import '../../entities/unidad_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../entities/producto_entity.dart';
import '../../usecases/agrupacion/agrupacion_db_usecase.dart';
import '../../usecases/agrupacion/agrupacion_usecase.dart';
import '../../usecases/convocatoria/convocatoria_exports.dart';
import '../../usecases/departamento/departamento_db_usecase.dart';
import '../../usecases/departamento/departamento_usecase.dart';
import '../../usecases/estado_visita/estado_visita_db_usecase.dart';
import '../../usecases/estado_visita/estado_visita_usecase.dart';
import '../../usecases/genero/genero_db_usecase.dart';
import '../../usecases/genero/genero_usecase.dart';
import '../../usecases/menu/menu_exports.dart';
import '../../usecases/municipio/municipio_db_usecase.dart';
import '../../usecases/municipio/municipio_usecase.dart';
import '../../usecases/perfiles/perfiles_exports.dart';
import '../../usecases/tipo_proyecto/tipo_proyecto_exports.dart';
import '../../usecases/tipo_visita/tipo_visita_db_usecase.dart';
import '../../usecases/tipo_visita/tipo_visita_usecase.dart';
import '../../usecases/unidad/unidad_exports.dart';
import '../../usecases/producto/producto_exports.dart';

part 'download_sync_event.dart';
part 'download_sync_state.dart';

class DownloadSyncBloc extends Bloc<DownloadSyncEvent, DownloadSyncState> {
  final MenuUsecase menu;
  final MenuUsecaseDB menuDB;

  final ConvocatoriaUsecase convocatoria;
  final ConvocatoriaUsecaseDB convocatoriaDB;

  final TipoProyectoUsecase tipoProyecto;
  final TipoProyectoUsecaseDB tipoProyectoDB;

  final UnidadUsecase unidad;
  final UnidadUsecaseDB unidadDB;

  final PerfilesUsecase perfiles;
  final PerfilesUsecaseDB perfilesDB;

  final ProductoUsecase productos;
  final ProductoUsecaseDB productosDB;

  final GeneroUsecase generos;
  final GeneroUsecaseDB generosDB;

  final DepartamentoUsecase departamentos;
  final DepartamentoUsecaseDB departamentosDB;

  final MunicipioUsecase municipios;
  final MunicipioUsecaseDB municipiosDB;

  final TipoVisitaUsecase tipoVisita;
  final TipoVisitaUsecaseDB tipoVisitaDB;

  final EstadoVisitaUsecase estadoVisita;
  final EstadoVisitaUsecaseDB estadoVisitaDB;

  final AgrupacionUsecase agrupacion;
  final AgrupacionUsecaseDB agrupacionDB;

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
    required this.generos,
    required this.generosDB,
    required this.departamentos,
    required this.departamentosDB,
    required this.municipios,
    required this.municipiosDB,
    required this.tipoVisita,
    required this.tipoVisitaDB,
    required this.estadoVisita,
    required this.estadoVisitaDB,
    required this.agrupacion,
    required this.agrupacionDB,
  }) : super(DownloadSyncInitial()) {
    on<DownloadStarted>((event, emit) async {
      final usuario = event.usuario;

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Menús',
          counter: state.progressModel!.counter + 1)));
      await downloadMenu(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Convocatorias',
          counter: state.progressModel!.counter + 1)));
      await downloadConvocatorias(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos Proyectos',
          counter: state.progressModel!.counter + 1)));
      await downloadTiposProyectos(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Unidades',
          counter: state.progressModel!.counter + 1)));
      await downloadUnidades(usuario, emit);

      /*   emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Perfiles',
          counter: state.progressModel!.counter + 1)));
      await downloadPerfiles(usuario, emit);
 */
      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Productos',
          counter: state.progressModel!.counter + 1)));
      await downloadProductos(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Géneros',
          counter: state.progressModel!.counter + 1)));
      await downloadGeneros(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Departamentos',
          counter: state.progressModel!.counter + 1)));
      await downloadDepartamentos(usuario, emit);

      /*  emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Municipios',
          counter: state.progressModel!.counter + 1)));
      await downloadMunicipios(usuario, emit); */

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos Visita',
          counter: state.progressModel!.counter + 1)));
      await downloadTiposVisitas(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Estados Visita',
          counter: state.progressModel!.counter + 1)));
      await downloadEstadosVisitas(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Agrupaciones',
          counter: state.progressModel!.counter + 1)));
      await downloadAgrupaciones(usuario, emit);

      emit(DownloadSyncSuccess());
    });

    on<DownloadSyncError>(
        (event, emit) => emit(DownloadSyncFailure(event.message)));
  }

  Future<void> downloadMenu(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await menu.getMenuUsecase(usuario);
    result.fold((failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveMenu(data, emit));
  }

  Future<void> saveMenu(
      List<MenuEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await menuDB.saveMenuUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadConvocatorias(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await convocatoria.getConvocatoriasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveConvocatorias(data, emit));
  }

  Future<void> saveConvocatorias(
      List<ConvocatoriaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await convocatoriaDB.saveConvocatoriaUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadTiposProyectos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoProyecto.getTiposProyectosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposProyectos(data, emit));
  }

  Future<void> saveTiposProyectos(
      List<TipoProyectoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await tipoProyectoDB.saveTiposProyectosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadUnidades(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await unidad.getUnidadesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveUnidades(data, emit));
  }

  Future<void> saveUnidades(
      List<UnidadEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await unidadDB.saveUnidadesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadPerfiles(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfiles.getPerfilesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await savePerfiles(data, emit));
  }

  Future<void> savePerfiles(
      List<PerfilEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await perfilesDB.savePerfilesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadProductos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await productos.getProductosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveProductos(data, emit));
  }

  Future<void> saveProductos(
      List<ProductoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await productosDB.saveProductoUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadGeneros(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await generos.getGenerosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveGeneros(data, emit));
  }

  Future<void> saveGeneros(
      List<GeneroEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await generosDB.saveGenerosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadDepartamentos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await departamentos.getDepartamentosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveDepartamentos(data, emit));
  }

  Future<void> saveDepartamentos(
      List<DepartamentoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await departamentosDB.saveDepartamentosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadMunicipios(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await municipios.getMunicipiosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveMunicipios(data, emit));
  }

  Future<void> saveMunicipios(
      List<MunicipioEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await municipiosDB.saveMunicipiosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadTiposVisitas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoVisita.getTiposVisitasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposVisitas(data, emit));
  }

  Future<void> saveTiposVisitas(
      List<TipoVisitaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await tipoVisitaDB.saveTiposVisitasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadEstadosVisitas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await estadoVisita.getEstadosVisitasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveEstadosVisitas(data, emit));
  }

  Future<void> saveEstadosVisitas(
      List<EstadoVisitaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await estadoVisitaDB.saveEstadosVisitasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadAgrupaciones(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await agrupacion.getAgrupacionesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveAgrupaciones(data, emit));
  }

  Future<void> saveAgrupaciones(
      List<AgrupacionEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await agrupacionDB.saveAgrupacionesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }
  /* List<MenuEntity> preinversionMenuSorted(List<MenuEntity> menu) {
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
  } */
}
