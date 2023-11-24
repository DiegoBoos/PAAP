class ConvocatoriaEntity {
  ConvocatoriaEntity({
    this.convocatoriaId,
    this.nombre,
    this.descripcion,
    this.fechaInicial,
    this.fechaFinal,
    this.recursos,
  });

  String? convocatoriaId;
  String? nombre;
  String? descripcion;
  String? fechaInicial;
  String? fechaFinal;
  String? recursos;

  Map<String, dynamic> toJson() => {
        "ConvocatoriaId": convocatoriaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "FechaInicial": fechaInicial,
        "FechaFinal": fechaFinal,
        "Recursos": recursos,
      };
}
