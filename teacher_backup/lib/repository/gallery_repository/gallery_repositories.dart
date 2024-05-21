import 'package:core/core.dart';
import 'package:teacher/model/gallery_album_model.dart';
import 'package:teacher/model/gallery_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';
import '../../src/services/network_services/api_client.dart';

abstract class GalleryRepository {
  Future<GalleryAlbumModel> getListGallery(int? teacherId, [int page = 1]);
  Future<GalleryModel> getDetailGallery(int? galleryID, int? pupilID);
}

class GalleryRepositoryImpl implements GalleryRepository {
  @override
  Future<GalleryAlbumModel> getListGallery(int? teacherId,
      [int page = 1]) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(ApiPath.getListGalleryAlbum, headers: {
        'Authorization': 'Bearer $accessToken',
      }).get({
        'teacher_id': teacherId,
        // 'page': page.toInt(),
      });

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