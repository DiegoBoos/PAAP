part of 'perfil_preinversion_cofinanciador_rubro_cubit.dart';

abstract class PerfilPreInversionCofinanciadorRubroState extends Equatable {
  final PerfilPreInversionCofinanciadorRubroEntity
      perfilPreInversionCofinanciadorRubro;

  const PerfilPreInversionCofinanciadorRubroState(
      {required this.perfilPreInversionCofinanciadorRubro});

  @override
  List<Object?> get props => [perfilPreInversionCofinanciadorRubro];
}

class PerfilPreInversionCofinanciadorRubroInitial
    extends PerfilPreInversionCofinanciadorRubroState {
  PerfilPreInversionCofinanciadorRubroInitial()
      : super(perfilPreInversionCofinanciadorRubro: initObject());
}

class PerfilPreInversionCofinanciadorRubroLoading
    extends PerfilPreInversionCofinanciadorRubroState {
  const PerfilPreInversionCofinanciadorRubroLoading(
      {required super.perfilPreInversionCofinanciadorRubro});
}

class PerfilPreInversionCofinanciadorRubroLoaded
    extends PerfilPreInversionCofinanciadorRubroState {
  final PerfilPreInversionCofinanciadorRubroEntity
      perfilPreInversionCofinanciadorRubroLoaded;

  const PerfilPreInversionCofinanciadorRubroLoaded(
      this.perfilPreInversionCofinanciadorRubroLoaded)
      : super(
            perfilPreInversionCofinanciadorRubro:
                perfilPreInversionCofinanciadorRubroLoaded);
}

class PerfilPreInversionCofinanciadorRubroChanged
    extends PerfilPreInversionCofinanciadorRubroState {
  final PerfilPreInversionCofinanciadorRubroEntity
      perfilPreInversionCofinanciadorRubroChanged;

  const PerfilPreInversionCofinanciadorRubroChanged(
      this.perfilPreInversionCofinanciadorRubroChanged)
      : super(
            perfilPreInversionCofinanciadorRubro:
                perfilPreInversionCofinanciadorRubroChanged);
}

class PerfilPreInversionCofinanciadorRubroSaved
    extends PerfilPreInversionCofinanciadorRubroState {
  PerfilPreInversionCofinanciadorRubroSaved()
      : super(perfilPreInversionCofinanciadorRubro: initObject());
}

class PerfilPreInversionCofinanciadorRubroError
    extends PerfilPreInversionCofinanciadorRubroState {
  final String message;

  PerfilPreInversionCofinanciadorRubroError(this.message)
      : super(perfilPreInversionCofinanciadorRubro: initObject());
  @override
  List<Object?> get props => [message];
}

PerfilPreInversionCofinanciadorRubroEntity initObject() =>
    PerfilPreInversionCofinanciadorRubroEntity(
        perfilPreInversionId: '',
        cofinanciadorId: '',
        desembolsoId: '',
        actividadFinancieraId: '',
        rubroId: '',
        valor: '',
        recordStatus: '');
