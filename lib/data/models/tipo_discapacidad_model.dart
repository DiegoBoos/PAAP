import 'package:paap/domain/entities/tipo_discapacidad_entity.dart';

class TipoDiscapacidadModel extends TipoDiscapacidadEntity {
  TipoDiscapacidadModel({
    required String tipoDiscapacidadId,
    required String nombre,
    required String descripcion,
  }) : super(
            tipoDiscapacidadId: tipoDiscapacidadId,
            nombre: nombre,
            descripcion: descripcion);

  factory TipoDiscapacidadModel.fromJson(Map<String, dynamic> json) =>
      TipoDiscapacidadModel(
        tipoDiscapacidadId: json["TipoDiscapacidadId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "TipoDiscapacidadId": tipoDiscapacidadId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
