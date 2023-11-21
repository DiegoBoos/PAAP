class ConvocatoriaEntity {
  ConvocatoriaEntity({
    required this.convocatoriaId,
    required this.nombre,
    required this.descripcion,
    required this.fechaInicial,
    required this.fechaFinal,
    required this.recursos,
  });

  String convocatoriaId;
  String nombre;
  String descripcion;
  String fechaInicial;
  String fechaFinal;
  String recursos;

  Map<String, dynamic> toJson() => {
        "ConvocatoriaId": convocatoriaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "FechaInicial": fechaInicial,
        "FechaFinal": fechaFinal,
        "Recursos": recursos,
      };
}
