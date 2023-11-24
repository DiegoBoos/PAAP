class AlianzasEntity {
  AlianzasEntity({
    this.id,
    this.nombre,
    this.abreviatura,
    this.valorProyecto,
    this.incentivoModular,
    this.ubicacion,
    this.categorizacion,
  });

  String? id;
  String? nombre;
  String? abreviatura;
  String? valorProyecto;
  String? incentivoModular;
  String? ubicacion;
  String? categorizacion;

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
