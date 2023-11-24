import 'package:paap/domain/entities/tipo_identificacion_entity.dart';

class TipoIdentificacionModel extends TipoIdentificacionEntity {
  TipoIdentificacionModel({String? tipoIdentificacionId, String? nombre})
      : super(tipoIdentificacionId: tipoIdentificacionId, nombre: nombre);

  factory TipoIdentificacionModel.fromJson(Map<String, dynamic> json) =>
      TipoIdentificacionModel(
        tipoIdentificacionId: json["TipoIdentificacionId"],
        nombre: json["Nombre"],
      );
}
