import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';

abstract class IServices {
  Future<List<PublicationsResponseForList>> getPublications();
  Future<PublicationDetail> getPublication(int id);
}