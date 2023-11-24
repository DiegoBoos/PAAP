import 'package:paap/domain/entities/tipo_proyecto_entity.dart';

class TipoProyectoModel extends TipoProyectoEntity {
  TipoProyectoModel(
      {String? tipoProyectoId, String? nombre, String? descripcion})
      : super(
            tipoProyectoId: tipoProyectoId,
            nombre: nombre,
            descripcion: descripcion);

  factory TipoProyectoModel.fromJson(Map<String, dynamic> json) =>
      TipoProyectoModel(
        tipoProyectoId: json["TipoProyectoId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );
}
