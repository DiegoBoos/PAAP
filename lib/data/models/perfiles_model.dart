import 'package:paap/domain/entities/perfiles_entity.dart';

class PerfilesModel extends PerfilesEntity {
  PerfilesModel({
    String? id,
    String? nombre,
    String? abreviatura,
    String? valorProyecto,
    String? incentivoModular,
    String? ubicacion,
    String? categorizacion,
  }) : super(
            id: id,
            nombre: nombre,
            abreviatura: abreviatura,
            valorProyecto: valorProyecto,
            incentivoModular: incentivoModular,
            ubicacion: ubicacion,
            categorizacion: categorizacion);

  factory PerfilesModel.fromJson(Map<String, dynamic> json) => PerfilesModel(
        id: json["ID"],
        nombre: json["Nombre"],
        abreviatura: json["Abreviatura"],
        valorProyecto: json["Valor_x0020_Proyécto"],
        incentivoModular: json["Incentivo_x0020_Módular"],
        ubicacion: json["Ubicación"],
        categorizacion: json["Categorización"],
      );
}
