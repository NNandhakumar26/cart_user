// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:toyskart/global/app_service.dart';

// class CategoryPickerViewBody extends StatelessWidget {
//   final RxString query = ''.obs;

//   CategoryPickerViewBody({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return SizedBox(
//       width: 400,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 5),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: TextField(
//               autofocus: true,
//               decoration: const InputDecoration(
//                 hintText: 'Search',
//                 suffixIcon: Icon(Icons.search),
//               ),
//               onChanged: query,
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 12.0,
//               horizontal: 16,
//             ),
//             child: const Text(
//               'search results',
//               style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//           // const SizedBox(height: 12),
//           Container(
//             constraints: BoxConstraints(
//               minHeight: 50,
//               maxHeight: screenHeight * .35,
//             ),
//             child: SingleChildScrollView(
//               child: Obx(() {
//                 final list = AppService.to.globalCategoriesList
//                     .where((e) =>
//                         e.name
//                             .toLowerCase()
//                             .contains(query.trim().toLowerCase()) ||
//                         e.value
//                             .toLowerCase()
//                             .contains(query.trim().toLowerCase()))
//                     .toList();
//                 // list.sort((a, b) => a.utc.compareTo(b.gmtOffset));
//                 return Column(
//                   // shrinkWrap: true,
//                   children: list.map((z) {
//                     return ListTile(
//                       trailing: Container(
//                           constraints: const BoxConstraints(maxWidth: 200),
//                           child: Text(z.value,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                   color: Colors.black.withOpacity(1),
//                                   fontSize: 14))),
//                       title: Text(
//                         z.name,
//                         style: TextStyle(
//                             color: Colors.black.withOpacity(1), fontSize: 14),
//                       ),
//                       onTap: () {
//                         Get.back(result: z);
//                       },
//                     );
//                   }).toList(),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
