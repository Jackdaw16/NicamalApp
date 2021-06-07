import 'package:nicamal_app/io/IFileManager.dart';
import 'package:nicamal_app/io/Services.dart';
import 'package:nicamal_app/models/Province.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileManager implements IFileManager {
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  Services services = Services();

  Future<List<String>> listConverted() async {
    List<Province> provinces = await services.getProvinces();
    if(provinces == null) {
      return null;
    } else {
      List<String> provincesToString = (provinces).map((e) => e.name.toString()).toList();

      return provincesToString;
    }
  }

  @override
  Future<bool> isSharedPreferencesSaved() async {
    SharedPreferences sharedPreferences = await preferences;
    if(await listConverted() == null) {
      return false;
    } else {
      return sharedPreferences.setStringList('provinces', await listConverted()).then((bool success) {return success;});
    }
  }

  @override
  Future<bool> isPreferencesExist() async {
    SharedPreferences sharedPreferences = await preferences;
    if (sharedPreferences.getStringList('provinces') == null) {
      return false;
    } else {
      return sharedPreferences.getStringList('provinces').isEmpty;
    }
  }

  @override
  Future<List<String>> getProvincesList() async {
    SharedPreferences sharedPreferences = await preferences;
    if(await isPreferencesExist()) {
      return sharedPreferences.getStringList('provinces');
    } else {
      return await listConverted();
    }
  }

}