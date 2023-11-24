class ProductoEntity {
  ProductoEntity(
      {this.id,
      this.nombre,
      this.unidad,
      this.simbolo,
      this.esProducto,
      this.esAsociado});

  String? id;
  String? nombre;
  String? unidad;
  String? simbolo;
  String? esProducto;
  String? esAsociado;

  Map<String, dynamic> toJson() => {
        "ProductoId": id,
        "Nombre": nombre,
        "Unidad": unidad,
        "Simbolo": simbolo,
        "EsProducto": esProducto,
        "EsAsociado": esAsociado
      };
}
