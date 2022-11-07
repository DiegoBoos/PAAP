import 'package:paap/domain/entities/alianza_entity.dart';

class AlianzaModel extends AlianzaEntity {
  AlianzaModel({
    required String id,
    required String nombre,
    required String abreviatura,
    required String valorProyecto,
    required String incentivoModular,
    required String ubicacion,
    String? categorizacion,
  }) : super(
            id: id,
            nombre: nombre,
            abreviatura: abreviatura,
            valorProyecto: valorProyecto,
            incentivoModular: incentivoModular,
            ubicacion: ubicacion,
            categorizacion: categorizacion);

  factory AlianzaModel.fromJson(Map<String, dynamic> json) => AlianzaModel(
        id: json["ID"],
        nombre: json["Nombre"],
        abreviatura: json["Abreviatura"],
        valorProyecto: json["Valor_x0020_Proyécto"],
        incentivoModular: json["Incentivo_x0020_Módular"],
        ubicacion: json["Ubicación"],
        categorizacion: json["Categorización"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "ID": id,
        "Nombre": nombre,
        "Abreviatura": abreviatura,
        "Valor_x0020_Proyécto": valorProyecto,
        "Incentivo_x0020_Módular": incentivoModular,
        "Ubicación": ubicacion,
        "Categorización": categorizacion,
      };
}
