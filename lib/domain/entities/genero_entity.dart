class GeneroEntity {
  GeneroEntity({required this.generoId, required this.nombre});

  String generoId;
  String nombre;

  Map<String, dynamic> toJson() => {"GeneroId": generoId, "Nombre": nombre};
}
