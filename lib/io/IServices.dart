import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';

abstract class IServices {
  Future<List<PublicationsResponseForList>> getPublications(int page);
  Future<List<PublicationsResponseForList>> getPublicationsWithFilters(int page, String text);
  Future<PublicationDetail> getPublication(int id);

}