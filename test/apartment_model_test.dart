// import 'package:test/test.dart';
// import 'package:todo/model/apartment_model.dart';

// void main() {
//   test(
//     'JsonSerializable',
//     () {
//       final apartment = Apartment(
//         name: 'Soche',
//         location: 'Manje',
//         allImages: ['one', 'Two', 'Three'],
//         properties: Properties(
//           beds: 1,
//           shower: 1,
//           area: 1,
//         ),
//         description: 'Test',
//         ownerDetails: OwnerDetails(
//           name: 'Ern',
//           phone: '099',
//           email: 'e.a@j.c',
//         ),
//       );
//       final apartment2 = Apartment.fromJson(apartment.toJson());
//       expect(apartment.name, apartment2.name);
//       expect(apartment.location, apartment2.location);
//       expect(apartment.allImages, apartment2.allImages);
//       expect(apartment.properties!.beds, apartment2.properties?.beds);
//     },
//     retry: 3,
//     timeout: const Timeout(
//       Duration(seconds: 5),
//     ),
//   );
// }
