class AgrupacionEntity {
  AgrupacionEntity(
      {this.agrupacionId, this.nombre, this.descripcion, this.convocatoriaId});

  String? agrupacionId;
  String? nombre;
  String? descripcion;
  String? convocatoriaId;

  Map<String, dynamic> toJson() => {
        "AgrupacionId": agrupacionId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "ConvocatoriaId": convocatoriaId
      };
}
