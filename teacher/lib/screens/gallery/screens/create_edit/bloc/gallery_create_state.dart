part of 'gallery_create_bloc.dart';

enum GalleryCreateStatus {
  init,
  loading,
  success,
  failure,
  loadingClass,
  loadingClassSuccess,
  createSuccess,
  createFailure,

  loadingSetValues,
  successSetValues,

  updateLoading,
  updateSuccess,
  updateFailure,

  deleteImagesSuccess,
  deleteImagesFailure,

  deleteSuccess,
  deleteFailure,
}

class GalleryCreateState extends Equatable {
  const GalleryCreateState({
    this.status = GalleryCreateStatus.init,
    this.listYear = const [],
    this.selectedYear = '',
    this.listClass = const [],
    required this.selectedClass,
    this.initImages = const [],
    required this.selectedImages,
    required this.albumDetail,
    this.message = '',
  });

  final GalleryCreateStatus status;

  final List<String> listYear;
  final String selectedYear;
  final List<GalleryClass> listClass;
  final GalleryClass selectedClass;

  final List<File> initImages;
  final List<File> selectedImages;
  final Gallery albumDetail;
  final String message;

  @override
  List<Object?> get props => [
        status,
        listYear,
        selectedYear,
        listClass,
        selectedClass,
        initImages,
        selectedImages,
        albumDetail,
        message,
      ];

  GalleryCreateState copyWith({
    GalleryCreateStatus? status,
    List<String>? listYear,
    String? selectedYear,
    List<GalleryClass>? listClass,
    GalleryClass? selectedClass,
    List<File>? initImages,
    List<File>? selectedImages,
    Gallery? albumDetail,
    String? message,
  }) {
    return GalleryCreateState(
      status: status ?? this.status,
      listYear: listYear ?? this.listYear,
      selectedYear: selectedYear ?? this.selectedYear,
      listClass: listClass ?? this.listClass,
      selectedClass: selectedClass ?? this.selectedClass,
      initImages: initImages ?? this.initImages,
      selectedImages: selectedImages ?? this.selectedImages,
      albumDetail: albumDetail ?? this.albumDetail,
      message: message ?? this.message,
    );
  }
}
