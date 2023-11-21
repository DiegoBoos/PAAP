import 'package:paap/domain/entities/tipo_discapacidad_entity.dart';

class TipoDiscapacidadModel extends TipoDiscapacidadEntity {
  TipoDiscapacidadModel({
    required String tipoDiscapacidadId,
    String? nombre,
    String? descripcion,
  }) : super(
            tipoDiscapacidadId: tipoDiscapacidadId,
            nombre: nombre ?? '',
            descripcion: descripcion ?? '');

  factory TipoDiscapacidadModel.fromJson(Map<String, dynamic> json) =>
      TipoDiscapacidadModel(
        tipoDiscapacidadId: json["TipoDiscapacidadId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );
}
