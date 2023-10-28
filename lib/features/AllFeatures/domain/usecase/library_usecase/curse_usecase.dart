import 'package:dartz/dartz.dart';
import 'package:university/core/widget/header_bar.dart';
import '../../../../../core/error/failure.dart';
import '../../repositories/library_repositories/library_repository.dart';

class GetCoursesUsecase {
  final LibraryRepository rerpository;

  GetCoursesUsecase({required this.rerpository});

  Future<Either<Failure, List<Header>>> call() async {
    return await rerpository.getCourse();
  }
}
