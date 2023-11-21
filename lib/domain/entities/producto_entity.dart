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

  Map<String, dynamic> toJson() => {
        "ProductoId": id,
        "Nombre": nombre,
        "Unidad": unidad,
        "Simbolo": simbolo,
        "EsProducto": esProducto,
        "EsAsociado": esAsociado
      };
}
