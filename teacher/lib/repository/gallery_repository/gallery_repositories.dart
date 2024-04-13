import 'package:core/core.dart';
import 'package:teacher/model/gallery_album_model.dart';
import 'package:teacher/model/gallery_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class GalleryRepository {
  Future<GalleryAlbumModel> getListGallery(
      int? pupilID, int? schoolID, String? schoolBrand);
  Future<GalleryModel> getDetailGallery(int? galleryID, int? pupilID);
}

class GalleryRepositoryImpl implements GalleryRepository {
  @override
  Future<GalleryAlbumModel> getListGallery(
      int? pupilID, int? schoolID, String? schoolBrand) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
          '${ApiPath.getListGalleryAlbum}?pupil_id=$pupilID',
          headers: {
            'Authorization': 'Bearer $accessToken',
            'School-Id': '$schoolID',
            'School-Brand': '$schoolBrand'
          }).get();

      if (isNullOrEmpty(res['data'])) return GalleryAlbumModel();

      return GalleryAlbumModel.fromJson(res['data']);
    } catch (e) {
      Log.e('$e',
          name: 'Get List Gallery Error GalleryRepository -> getListGallery()');
    }
    return GalleryAlbumModel();
  }

  @override
  Future<GalleryModel> getDetailGallery(int? galleryID, int? pupilID) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        '${ApiPath.getDetailGalleryImage}?gallery_id=$galleryID&pupil_id=$pupilID',
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).get();

      if (isNullOrEmpty(res['data'])) return GalleryModel();

      return GalleryModel.fromJson(res['data']);
    } catch (e) {
      Log.e('$e',
          name:
              'Get Detail Gallery Error GalleryRepository -> getDetailGallery()');
    }
    return GalleryModel();
  }
}
