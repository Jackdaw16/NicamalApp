abstract class IFileManager {
  Future<bool> isSharedPreferencesSaved();
  Future<bool> isPreferencesExist();
  Future<List<String>> getProvincesList();
}