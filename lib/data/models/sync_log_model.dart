import '../../domain/entities/sync_log_entity.dart';

class SyncLogModel extends SyncLogEntity {
  SyncLogModel({required String tabla, required int cantidadRegistros})
      : super(tabla: tabla, cantidadRegistros: cantidadRegistros);

  factory SyncLogModel.fromJson(Map<String, dynamic> json) => SyncLogModel(
        tabla: json["Tabla"],
        cantidadRegistros: json["CantidadRegistros"],
      );
}
