import 'package:nicamal_app/models/Province.dart';
import 'package:nicamal_app/models/viewModels/disappearance_view_model.dart';
import 'package:nicamal_app/models/viewModels/publication_view_model.dart';
import 'package:nicamal_app/models/viewModels/shelter_view_model.dart';
import 'package:nicamal_app/models/viewModels/user_view_model.dart';

abstract class IServices {
  /*Publication calls*/
  Future<List<PublicationsList>> getPublications(int page);
  Future<List<PublicationsList>> getPublicationsWithFilters(int page, String text);
  Future<PublicationDetail> getPublication(String id);

  /*Disappearances calls*/
  Future<List<DisappearanceListResponse>> getDisappearances(int page);
  Future<DisappearanceDetail> getDisappearance(String id);
  Future<DisappearanceDetail> postDisappearance(DisappearanceDetail disappearance);

  /*Provinces call*/
  Future<List<Province>> getProvinces();

  /*Shelter calls*/
  Future<List<UserShelterList>> getShelters(int page);
  Future<List<UserShelterList>> getSheltersWithFilters(int page, String text);
  Future<UserShelterDetail> getShelter(String id);
  Future<List<PublicationsList>> getShelterPublications(String id, int page);
  Future<List<PublicationsList>> getShelterPublicationsFilters(String id, int page, String text);
  Future<List<PublicationsList>> getShelterPublicationsUrgent(String id, int page);
  Future<List<PublicationsList>> getShelterPublicationsUrgentFilters(String id, int page, String text);
  Future<UserShelterLoggedIn> userShelterLogIn(UserLogIn user);

  /*User calls*/
  Future<UserLoggedIn> userLogIn(UserLogIn user);

}