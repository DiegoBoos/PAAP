class ProductoEntity {
  ProductoEntity(
      {required this.id,
      required this.nombre,
      required this.unidad,
      required this.simbolo,
      required this.esProducto,
      required this.esAsociado});

  String id;
  String nombre;
  String unidad;
  String simbolo;
  String esProducto;
  String esAsociado;

  factory ProductoEntity.fromJson(Map<String, dynamic> json) => ProductoEntity(
        id: json["ProductoId"],
        nombre: json["Nombre"],
        unidad: json["Unidad"],
        simbolo: json["Simbolo"],
        esProducto: json["EsProducto"],
        esAsociado: json["EsAsociado"],
      );

  Map<String, dynamic> toJson() => {
        "ProductoId": id,
        "Nombre": nombre,
        "Unidad": unidad,
        "Simbolo": simbolo,
        "EsProducto": esProducto,
        "EsAsociado": esAsociado
      };
}
