import 'package:technical_assessment/ContactModel.dart';

class Contacts {
  static List getContactList() => contactList;
  static List<ContactModel> contactList = [
    ContactModel(
      name: 'Abu',
      phone: '123',
      date: '2021-07-17 10:02:46.501222',
    ),
    ContactModel(
      name: 'Bakar',
      phone: '111',
      date: '2021-06-17 10:02:46.501222',
    ),
    ContactModel(
      name: 'Abi',
      phone: '222',
      date: '2021-05-17 10:02:46.501222',
    ),
    ContactModel(
      name: 'Abo',
      phone: '333',
      date: '2021-04-17 10:02:46.501222',
    ),
    ContactModel(
      name: 'Aba',
      phone: '444',
      date: '2021-04-17 10:02:46.501872',
    ),
  ];
}
