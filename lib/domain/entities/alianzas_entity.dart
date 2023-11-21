class AlianzasEntity {
  AlianzasEntity({
    required this.id,
    required this.nombre,
    required this.abreviatura,
    required this.valorProyecto,
    required this.incentivoModular,
    required this.ubicacion,
    required this.categorizacion,
  });

  String id;
  String nombre;
  String abreviatura;
  String valorProyecto;
  String incentivoModular;
  String ubicacion;
  String categorizacion;

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
