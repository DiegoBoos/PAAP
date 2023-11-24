import 'package:paap/domain/entities/tipo_tenencia_entity.dart';

class TipoTenenciaModel extends TipoTenenciaEntity {
  TipoTenenciaModel({
    String? tipoTenenciaId,
    String? nombre,
    String? descripcion,
  }) : super(
            tipoTenenciaId: tipoTenenciaId,
            nombre: nombre,
            descripcion: descripcion);

  factory TipoTenenciaModel.fromJson(Map<String, dynamic> json) =>
      TipoTenenciaModel(
        tipoTenenciaId: json["TipoTenenciaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );
}
