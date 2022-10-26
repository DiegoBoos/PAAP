import '../../domain/entities/tipo_proyecto_entity.dart';

class TipoProyectoModel extends TipoProyectoEntity {
  TipoProyectoModel(
      {required String id, required String nombre, required String descripcion})
      : super(id: id, nombre: nombre, descripcion: descripcion);

  factory TipoProyectoModel.fromJson(Map<String, dynamic> json) =>
      TipoProyectoModel(
        id: json["TipoProyectoId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  @override
  Map<String, dynamic> toJson() =>
      {"TipoProyectoId": id, "Nombre": nombre, "Descripcion": descripcion};
}
