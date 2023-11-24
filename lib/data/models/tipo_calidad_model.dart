import 'package:paap/domain/entities/tipo_calidad_entity.dart';

class TipoCalidadModel extends TipoCalidadEntity {
  TipoCalidadModel({
    String? tipoCalidadId,
    String? nombre,
    String? descripcion,
  }) : super(
            tipoCalidadId: tipoCalidadId,
            nombre: nombre,
            descripcion: descripcion);

  factory TipoCalidadModel.fromJson(Map<String, dynamic> json) =>
      TipoCalidadModel(
        tipoCalidadId: json["TipoCalidadId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );
}
