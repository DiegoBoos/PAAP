import 'package:paap/domain/entities/tipo_identificacion_entity.dart';

class TipoIdentificacionModel extends TipoIdentificacionEntity {
  TipoIdentificacionModel(
      {required String tipoIdentificacionId, String? nombre})
      : super(tipoIdentificacionId: tipoIdentificacionId, nombre: nombre ?? '');

  factory TipoIdentificacionModel.fromJson(Map<String, dynamic> json) =>
      TipoIdentificacionModel(
        tipoIdentificacionId: json["TipoIdentificacionId"],
        nombre: json["Nombre"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "TipoIdentificacionId": tipoIdentificacionId,
        "Nombre": nombre,
      };
}
