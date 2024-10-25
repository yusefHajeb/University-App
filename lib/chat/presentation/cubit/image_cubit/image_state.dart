part of 'image_cubit.dart';

class ImageState extends Equatable {
  final ImageStatus status;

  const ImageState(this.status);

  @override
  List<Object?> get props => [status];
}
