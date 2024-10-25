// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_blurhash/flutter_blurhash.dart';
// import 'package:unvirstiychat/features/presentation/cubit/cubit/image_cubit.dart';

// class CustomWidget extends StatelessWidget {
//   final String text;
//   final String linkImageRootImage;
//   final ontap;

//   CustomWidget(
//       {required this.text,
//       required this.linkImageRootImage,
//       required this.ontap});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ImageCubit, ImageStatus>(
//       builder: (context, state) {
//         return GestureDetector(
//           onTap: () {
//             //if (text == context.read<ImageCubit>().retelectedImage())
//             ontap();

//             print("object");
//           },
//           child: state == ImageStatus.selected
//               ? CachedNetworkImage(
//                   imageUrl: context.read<ImageCubit>().retImage(),
//                   fit: BoxFit.cover,
//                   progressIndicatorBuilder: (context, url, downloadProgress) =>
//                       SizedBox(
//                           height: 50,
//                           width: 50,
//                           child: Container(
//                               margin: EdgeInsets.all(20),
//                               child: CircularProgressIndicator())),
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                 )
//               : text != "text"
//                   ? Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Container(
//                           height: 250,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             color: Colors.blue,
//                           ),
//                           child: BlurHash(
//                             hash: 'L5H2EC=PM+yV0g-mq.wG9c010J}I',
//                             imageFit: BoxFit.cover,
//                           ),
//                         ),
//                         Icon(
//                           Icons.download,
//                           color: Colors.white,
//                           size: 40,
//                         ),
//                       ],
//                     )
//                   : Text(
//                       text,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16),
//                     ),
//         );
//       },
//     );
//   }
// }
