import 'dart:convert';

class AlbumData {
  final List<Gallery> items;
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;

  AlbumData({
    required this.items,
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory AlbumData.fromJson(Map<String, dynamic> json) =>
      AlbumData.fromMap(json);

  factory AlbumData.fromMap(Map<String, dynamic> map) {
    var itemsJson = map['items'] as List;
    List<Gallery> itemsList = itemsJson.map((i) => Gallery.fromMap(i)).toList();

    return AlbumData(
      items: itemsList,
      total: map['total'],
      count: map['count'],
      perPage: map['per_page'],
      currentPage: map['current_page'],
      totalPages: map['total_pages'],
    );
  }

  Map<String, dynamic> toMap() => {
        'items': items.map((item) => item.toMap()).toList(),
        'total': total,
        'count': count,
        'per_page': perPage,
        'current_page': currentPage,
        'total_pages': totalPages,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AlbumData{items: $items, total: $total, count: $count, perPage: $perPage, currentPage: $currentPage, totalPages: $totalPages}';
  }

  static AlbumData get empty => AlbumData(
        items: [],
        total: 0,
        count: 0,
        perPage: 0,
        currentPage: 0,
        totalPages: 0,
      );
}

class Gallery {
  final int galleryId;
  final String galleryName;
  final String learnYear;
  final int schoolId;
  final int galleryNumber;
  final List<GalleryImage> galleryImages;

  Gallery({
    required this.galleryId,
    required this.galleryName,
    required this.learnYear,
    required this.schoolId,
    required this.galleryNumber,
    required this.galleryImages,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery.fromMap(json);

  factory Gallery.fromMap(Map<String, dynamic> map) {
    var imagesJson = map['gallery_images'] as List;
    List<GalleryImage> imagesList =
        imagesJson.map((i) => GalleryImage.fromMap(i)).toList();

    return Gallery(
      galleryId: map['gallery_id'],
      galleryName: map['gallery_name'],
      learnYear: map['learn_year'],
      schoolId: map['school_id'],
      galleryNumber: map['gallery_number'],
      galleryImages: imagesList,
    );
  }

  Map<String, dynamic> toMap() => {
        'gallery_id': galleryId,
        'gallery_name': galleryName,
        'learn_year': learnYear,
        'school_id': schoolId,
        'gallery_number': galleryNumber,
        'gallery_images': galleryImages.map((image) => image.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Gallery{galleryId: $galleryId, galleryName: $galleryName, learnYear: $learnYear, schoolId: $schoolId, galleryNumber: $galleryNumber, galleryImages: $galleryImages}';
  }

  static Gallery get empty => Gallery(
        galleryId: 0,
        galleryName: '',
        learnYear: '',
        schoolId: 0,
        galleryNumber: 0,
        galleryImages: [],
      );
}

class GalleryImage {
  final int id;
  final String name;
  final String description;
  final ImageUrl images;

  GalleryImage({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
  });

  factory GalleryImage.fromJson(Map<String, dynamic> json) =>
      GalleryImage.fromMap(json);

  factory GalleryImage.fromMap(Map<String, dynamic> map) {
    return GalleryImage(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      images: ImageUrl.fromMap(map['images']),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'images': images.toMap(),
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'GalleryImage{id: $id, name: $name, description: $description, images: $images}';
  }

  static GalleryImage get empty => GalleryImage(
        id: 0,
        name: '',
        description: '',
        images: ImageUrl.empty,
      );
}

class ImageUrl {
  final String web;
  final String mobile;

  ImageUrl({
    required this.web,
    required this.mobile,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) =>
      ImageUrl.fromMap(json);

  factory ImageUrl.fromMap(Map<String, dynamic> map) {
    return ImageUrl(
      web: map['web'],
      mobile: map['mobile'],
    );
  }

  Map<String, dynamic> toMap() => {
        'web': web,
        'mobile': mobile,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ImageUrl{web: $web, mobile: $mobile}';
  }

  static ImageUrl get empty => ImageUrl(
        web: '',
        mobile: '',
      );
}
