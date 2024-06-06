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
    required this.selectedImages,
    this.message = '',
  });

  final GalleryCreateStatus status;

  final List<String> listYear;
  final String selectedYear;
  final List<GalleryClass> listClass;
  final GalleryClass selectedClass;

  final List<File> selectedImages;
  final String message;

  @override
  List<Object?> get props => [
        status,
        listYear,
        selectedYear,
        listClass,
        selectedClass,
        selectedImages,
        message,
      ];

  GalleryCreateState copyWith({
    GalleryCreateStatus? status,
    List<String>? listYear,
    String? selectedYear,
    List<GalleryClass>? listClass,
    GalleryClass? selectedClass,
    List<File>? selectedImages,
    String? message,
  }) {
    return GalleryCreateState(
      status: status ?? this.status,
      listYear: listYear ?? this.listYear,
      selectedYear: selectedYear ?? this.selectedYear,
      listClass: listClass ?? this.listClass,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedImages: selectedImages ?? this.selectedImages,
      message: message ?? this.message,
    );
  }
}
