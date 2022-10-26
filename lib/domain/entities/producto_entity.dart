class ProductoEntity {
  ProductoEntity(
      {required this.id,
      required this.nombre,
      required this.unidadid,
      required this.esproducto,
      required this.esasociado});

  String id;
  String nombre;
  String unidadid;
  String esproducto;
  String esasociado;

  factory ProductoEntity.fromJson(Map<String, dynamic> json) => ProductoEntity(
        id: json["ProductoId"],
        nombre: json["Nombre"],
        unidadid: json["UnidadId"],
        esproducto: json["EsProducto"],
        esasociado: json["EsAsociado"],
      );

  Map<String, dynamic> toJson() => {
        "ProductoId": id,
        "Nombre": nombre,
        "UnidadId": unidadid,
        "EsProducto": esproducto,
        "EsAsociado": esasociado
      };
}
