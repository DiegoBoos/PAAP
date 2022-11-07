import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/revision_entity.dart';
import '../../usecases/revision/revision_db_usecase.dart';
import '../../usecases/revision/revision_usecase.dart';

part 'revision_state.dart';

class RevisionCubit extends Cubit<RevisionState> {
  final RevisionUsecase revision;
  final RevisionUsecaseDB revisionDB;

  RevisionCubit({required this.revision, required this.revisionDB})
      : super(RevisionInitial()) {
    getRevisionDB();
  }

  void getRevisionDB() async {
    final result = await revisionDB.getRevisionesUsecaseDB();
    result.fold((failure) => emit(RevisionError(failure.properties.first)),
        (data) => emit(RevisionLoaded(data)));
  }
}
