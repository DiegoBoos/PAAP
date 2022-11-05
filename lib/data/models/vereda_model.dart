import 'package:paap/domain/entities/vereda_entity.dart';

class VeredaModel extends VeredaEntity {
  VeredaModel(
      {required String veredaId,
      required String nombre,
      required String codigoDane,
      required String municipioId})
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

  @override
  Map<String, dynamic> toJson() => {
        "VeredaId": veredaId,
        "Nombre": nombre,
        "CodigoDane": codigoDane,
        "MunicipioId": municipioId
      };
}
