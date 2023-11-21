import 'package:paap/domain/entities/tipo_actividad_productiva_entity.dart';

class TipoActividadProductivaModel extends TipoActividadProductivaEntity {
  TipoActividadProductivaModel({
    required String tipoActividadProductivaId,
    String? nombre,
    String? descripcion,
    required String tipoProyectoId,
  }) : super(
            tipoActividadProductivaId: tipoActividadProductivaId,
            nombre: nombre ?? '',
            descripcion: descripcion ?? '',
            tipoProyectoId: tipoProyectoId);

  factory TipoActividadProductivaModel.fromJson(Map<String, dynamic> json) =>
      TipoActividadProductivaModel(
        tipoActividadProductivaId: json["TipoActividadProductivaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        tipoProyectoId: json["TipoProyectoId"],
      );
}
