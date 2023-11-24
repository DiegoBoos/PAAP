import 'package:paap/domain/entities/tipo_movimiento_entity.dart';

class TipoMovimientoModel extends TipoMovimientoEntity {
  TipoMovimientoModel({
    String? tipoMovimientoId,
    String? nombre,
    String? descripcion,
  }) : super(
            tipoMovimientoId: tipoMovimientoId,
            nombre: nombre,
            descripcion: descripcion);

  factory TipoMovimientoModel.fromJson(Map<String, dynamic> json) =>
      TipoMovimientoModel(
        tipoMovimientoId: json["TipoMovimientoId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );
}
