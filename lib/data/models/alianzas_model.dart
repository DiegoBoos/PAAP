import 'package:paap/domain/entities/alianzas_entity.dart';

class AlianzasModel extends AlianzasEntity {
  AlianzasModel({
    required String id,
    String? nombre,
    String? abreviatura,
    String? valorProyecto,
    String? incentivoModular,
    String? ubicacion,
    String? categorizacion,
  }) : super(
            id: id,
            nombre: nombre ?? '',
            abreviatura: abreviatura ?? '',
            valorProyecto: valorProyecto ?? '',
            incentivoModular: incentivoModular ?? '',
            ubicacion: ubicacion ?? '',
            categorizacion: categorizacion ?? '');

  factory AlianzasModel.fromJson(Map<String, dynamic> json) => AlianzasModel(
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
