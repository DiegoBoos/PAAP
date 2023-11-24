import 'package:paap/domain/entities/tipo_entidad_entity.dart';

class TipoEntidadModel extends TipoEntidadEntity {
  TipoEntidadModel({String? tipoEntidadId, String? nombre})
      : super(tipoEntidadId: tipoEntidadId, nombre: nombre);

  factory TipoEntidadModel.fromJson(Map<String, dynamic> json) =>
      TipoEntidadModel(
          tipoEntidadId: json["TipoEntidadId"], nombre: json["Nombre"]);
}
