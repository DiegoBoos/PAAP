import 'package:paap/domain/entities/residencia_entity.dart';

class ResidenciaModel extends ResidenciaEntity {
  ResidenciaModel({String? residenciaId, String? nombre})
      : super(residenciaId: residenciaId, nombre: nombre);

  factory ResidenciaModel.fromJson(Map<String, dynamic> json) =>
      ResidenciaModel(
          residenciaId: json["ResidenciaId"], nombre: json["Nombre"]);
}
