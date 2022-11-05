import 'package:paap/domain/entities/residencia_entity.dart';

class ResidenciaModel extends ResidenciaEntity {
  ResidenciaModel({required String residenciaId, required String nombre})
      : super(residenciaId: residenciaId, nombre: nombre);

  factory ResidenciaModel.fromJson(Map<String, dynamic> json) =>
      ResidenciaModel(
          residenciaId: json["ResidenciaId"], nombre: json["Nombre"]);
  @override
  Map<String, dynamic> toJson() =>
      {"ResidenciaId": residenciaId, "Nombre": nombre};
}
