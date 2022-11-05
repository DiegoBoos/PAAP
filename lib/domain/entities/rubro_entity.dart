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

  factory RubroEntity.fromJson(Map<String, dynamic> json) => RubroEntity(
        rubroId: json["RubroId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        activo: json["Activo"],
        actividadFinancieraId: json["ActividadFinancieraId"],
      );

  Map<String, dynamic> toJson() => {
        "RubroId": rubroId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Activo": activo,
        "ActividadFinancieraId": actividadFinancieraId,
      };
}
