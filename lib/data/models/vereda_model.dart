import 'package:paap/domain/entities/vereda_entity.dart';

class VeredaModel extends VeredaEntity {
  VeredaModel(
      {String? veredaId,
      String? nombre,
      String? codigoDane,
      String? municipioId})
      : super(
            veredaId: veredaId,
            nombre: nombre,
            codigoDane: codigoDane,
            municipioId: municipioId);

  factory VeredaModel.fromJson(Map<String, dynamic> json) => VeredaModel(
        veredaId: json["VeredaId"],
        nombre: json["Nombre"],
        codigoDane: json["CodigoDane"],
        municipioId: json["MunicipioId"],
      );
}
