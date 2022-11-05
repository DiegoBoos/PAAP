import 'package:paap/domain/entities/actividad_financiera_entity.dart';

class ActividadFinancieraModel extends ActividadFinancieraEntity {
  ActividadFinancieraModel({
    required String actividadFinancieraId,
    required String nombre,
    required String descripcion,
    required String activo,
    required String tipoMovimientoId,
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

  @override
  Map<String, dynamic> toJson() => {
        "ActividadFinancieraId": actividadFinancieraId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Activo": activo,
        "TipoMovimientoId": tipoMovimientoId,
      };
}
