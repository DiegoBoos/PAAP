import 'package:paap/domain/entities/actividad_financiera_entity.dart';

class ActividadFinancieraModel extends ActividadFinancieraEntity {
  ActividadFinancieraModel({
    String? actividadFinancieraId,
    String? nombre,
    String? descripcion,
    String? activo,
    String? tipoMovimientoId,
  }) : super(
            actividadFinancieraId: actividadFinancieraId,
            nombre: nombre,
            descripcion: descripcion,
            activo: activo,
            tipoMovimientoId: tipoMovimientoId);

  factory ActividadFinancieraModel.fromJson(Map<String, dynamic> json) =>
      ActividadFinancieraModel(
        actividadFinancieraId: json["ActividadFinancieraId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        activo: json["Activo"],
        tipoMovimientoId: json["TipoMovimientoId"],
      );
}
