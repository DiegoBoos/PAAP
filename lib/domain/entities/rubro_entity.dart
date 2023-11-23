class RubroEntity {
  RubroEntity({
    this.rubroId,
    required this.nombre,
    required this.descripcion,
    this.activo,
    this.actividadFinancieraId,
  });

  String? rubroId;
  String nombre;
  String descripcion;
  String? activo;
  String? actividadFinancieraId;

  Map<String, dynamic> toJson() => {
        "RubroId": rubroId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Activo": activo,
        "ActividadFinancieraId": actividadFinancieraId,
      };
}
