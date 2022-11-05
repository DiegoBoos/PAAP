class AlianzaEntity {
  AlianzaEntity({
    required this.id,
    required this.nombre,
    required this.abreviatura,
    required this.valorProyecto,
    required this.incentivoModular,
    required this.ubicacion,
    this.categorizacion,
  });

  String id;
  String nombre;
  String abreviatura;
  String valorProyecto;
  String incentivoModular;
  String ubicacion;
  String? categorizacion;

  factory AlianzaEntity.fromJson(Map<String, dynamic> json) => AlianzaEntity(
        id: json["ID"],
        nombre: json["Nombre"],
        abreviatura: json["Abreviatura"],
        valorProyecto: json["Valor_x0020_Proyécto"],
        incentivoModular: json["Incentivo_x0020_Módular"],
        ubicacion: json["Ubicación"],
        categorizacion: json["Categorización"],
      );

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
