abstract class ObservationRepository {
  Future<void> createObservation();
  Future<List<dynamic>> getObservationSchedule();
}

class ObservationRepositoryImpl implements ObservationRepository {
  @override
  Future<void> createObservation() {
    // TODO: implement createObservation
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getObservationSchedule() {
    // TODO: implement getObservationSchedule
    throw UnimplementedError();
  }
}
