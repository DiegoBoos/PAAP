import 'package:paap/domain/entities/tipo_proyecto_entity.dart';

class TipoProyectoModel extends TipoProyectoEntity {
  TipoProyectoModel(
      {required String tipoProyectoId, String? nombre, String? descripcion})
      : super(
            tipoProyectoId: tipoProyectoId,
            nombre: nombre ?? '',
            descripcion: descripcion ?? '');

  factory TipoProyectoModel.fromJson(Map<String, dynamic> json) =>
      TipoProyectoModel(
        tipoProyectoId: json["TipoProyectoId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "TipoProyectoId": tipoProyectoId,
        "Nombre": nombre,
        "Descripcion": descripcion
      };
}
