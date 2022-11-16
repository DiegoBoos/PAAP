class IndicadorEntity {
  IndicadorEntity(
      {required this.indicadorId,
      required this.nombre,
      required this.meta,
      required this.productoObjetivoId,
      required this.producto});

  String indicadorId;
  String nombre;
  String meta;
  String productoObjetivoId;
  String producto;

  factory IndicadorEntity.fromJson(Map<String, dynamic> json) =>
      IndicadorEntity(
          indicadorId: json["IndicadorId"],
          nombre: json["Nombre"],
          meta: json["Meta"],
          productoObjetivoId: json["ProductoObjetivoId"],
          producto: json["Producto"]);

  Map<String, dynamic> toJson() => {
        "IndicadorId": indicadorId,
        "Nombre": nombre,
        "Meta": meta,
        "ProductoObjetivoId": productoObjetivoId,
        "Producto": producto,
      };
}
