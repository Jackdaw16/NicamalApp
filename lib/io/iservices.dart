import 'package:nicamal_app/models/Province.dart';
import 'package:nicamal_app/models/viewModels/disappearance_view_model.dart';
import 'package:nicamal_app/models/viewModels/publication_view_model.dart';

abstract class IServices {
  /*Publication calls*/
  Future<List<PublicationsList>> getPublications(int page);
  Future<List<PublicationsList>> getPublicationsWithFilters(int page, String text);
  Future<PublicationDetail> getPublication(String id);

  /*Disappearances calls*/
  Future<List<DisappearanceListResponse>> getDisappearances(int page);
  Future<DisappearanceDetail> getDisappearance(String id);
  Future<DisappearanceDetail> createDisappearance(DisappearanceDetail disappearance);

  /*Provinces call*/
  Future<List<Province>> getProvinces();

  /*Shelter calls*/

}