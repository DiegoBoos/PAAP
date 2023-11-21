import '../../domain/entities/estado_civil_entity.dart';

class EstadoCivilModel extends EstadoCivilEntity {
  EstadoCivilModel(
      {required String estadoCivilId, String? nombre, String? tieneConyuge})
      : super(
            estadoCivilId: estadoCivilId,
            nombre: nombre ?? '',
            tieneConyuge: tieneConyuge ?? '');

  factory EstadoCivilModel.fromJson(Map<String, dynamic> json) =>
      EstadoCivilModel(
          estadoCivilId: json["EstadoCivilId"],
          nombre: json["Nombre"],
          tieneConyuge: json["TieneConyuge"]);
}
