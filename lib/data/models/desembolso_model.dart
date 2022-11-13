import 'package:paap/domain/entities/desembolso_entity.dart';

class DesembolsoModel extends DesembolsoEntity {
  DesembolsoModel({required String desembolsoId, String? nombre})
      : super(desembolsoId: desembolsoId, nombre: nombre ?? '');

  factory DesembolsoModel.fromJson(Map<String, dynamic> json) =>
      DesembolsoModel(
          desembolsoId: json["DesembolsoId"], nombre: json["Nombre"]);

  @override
  Map<String, dynamic> toJson() =>
      {"DesembolsoId": desembolsoId, "Nombre": nombre};
}
