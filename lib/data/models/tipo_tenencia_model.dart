import 'package:paap/domain/entities/tipo_tenencia_entity.dart';

class TipoTenenciaModel extends TipoTenenciaEntity {
  TipoTenenciaModel({
    required String tipoTenenciaId,
    String? nombre,
    String? descripcion,
  }) : super(
            tipoTenenciaId: tipoTenenciaId,
            nombre: nombre ?? '',
            descripcion: descripcion ?? '');

  factory TipoTenenciaModel.fromJson(Map<String, dynamic> json) =>
      TipoTenenciaModel(
        tipoTenenciaId: json["TipoTenenciaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "TipoTenenciaId": tipoTenenciaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
