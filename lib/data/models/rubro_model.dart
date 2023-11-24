import 'package:paap/domain/entities/rubro_entity.dart';

class RubroModel extends RubroEntity {
  RubroModel({
    String? rubroId,
    String? nombre,
    String? descripcion,
    String? activo,
    required String actividadFinancieraId,
  }) : super(
            rubroId: rubroId,
            nombre: nombre,
            descripcion: descripcion,
            activo: activo,
            actividadFinancieraId: actividadFinancieraId);

  factory RubroModel.fromJson(Map<String, dynamic> json) => RubroModel(
        rubroId: json["RubroId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        activo: json["Activo"],
        actividadFinancieraId: json["ActividadFinancieraId"],
      );
}
