class ProductoObjetivoEntity {
  ProductoObjetivoEntity(
      {required this.productoObjetivoId,
      required this.nombre,
      required this.unidadId,
      required this.objetivoId,
      required this.objetivo,
      required this.proyecto,
      required this.unidad});

  String productoObjetivoId;
  String nombre;
  String unidadId;
  String objetivoId;
  String objetivo;
  String proyecto;
  String unidad;

  factory ProductoObjetivoEntity.fromJson(Map<String, dynamic> json) =>
      ProductoObjetivoEntity(
          productoObjetivoId: json["ProductoObjetivoId"],
          nombre: json["Nombre"],
          unidadId: json["UnidadId"],
          objetivoId: json["ObjetivoId"],
          objetivo: json["Objetivo"],
          proyecto: json["Proyecto"],
          unidad: json["Unidad"]);

  Map<String, dynamic> toJson() => {
        "ProductoObjetivoId": productoObjetivoId,
        "Nombre": nombre,
        "UnidadId": unidadId,
        "ObjetivoId": objetivoId,
        "Objetivo": objetivo,
        "Proyecto": proyecto,
        "Unidad": unidad
      };
}
