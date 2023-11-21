class RubroEntity {
  RubroEntity({
    required this.rubroId,
    required this.nombre,
    required this.descripcion,
    required this.activo,
    required this.actividadFinancieraId,
  });

  String rubroId;
  String nombre;
  String descripcion;
  String activo;
  String actividadFinancieraId;

  Map<String, dynamic> toJson() => {
        "RubroId": rubroId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Activo": activo,
        "ActividadFinancieraId": actividadFinancieraId,
      };
}
