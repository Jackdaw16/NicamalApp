import 'package:nicamal_app/models/Province.dart';
import 'package:nicamal_app/models/viewModels/DisappearanceViewModel.dart';
import 'package:nicamal_app/models/viewModels/PublicationViewModel.dart';

abstract class IServices {
  Future<List<PublicationsList>> getPublications(int page);
  Future<List<PublicationsList>> getPublicationsWithFilters(int page, String text);
  Future<PublicationDetail> getPublication(String id);

  Future<List<DisappearanceListResponse>> getDisappearances(int page);
  Future<DisappearanceDetail> getDisappearance(String id);
  Future<DisappearanceDetail> createDisappearance(DisappearanceDetail disappearance);

  Future<List<Province>> getProvinces();

}