import 'package:paap/domain/entities/departamento_entity.dart';

class DepartamentoModel extends DepartamentoEntity {
  DepartamentoModel(
      {required String id, String? nombre, required String paisid})
      : super(id: id, nombre: nombre ?? '', paisid: paisid);

  factory DepartamentoModel.fromJson(Map<String, dynamic> json) =>
      DepartamentoModel(
        id: json["DepartamentoId"],
        nombre: json["Nombre"],
        paisid: json["PaisId"],
      );

  @override
  Map<String, dynamic> toJson() =>
      {"DepartamentoId": id, "Nombre": nombre, "PaisId": paisid};
}
