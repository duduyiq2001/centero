class Resident {
  final String username;
  final String password;
  final int unit;
  final int id;
  final String propertyname;
  final DateTime leasestart;
  final DateTime leaseend;
  bool isloggedin;

  Resident(
      {required this.username,
      required this.password,
      required this.unit,
      required this.id,
      required this.propertyname,
      required this.leasestart,
      required this.leaseend,
      required this.isloggedin});
}

List<Resident> dummyData = [
  Resident(
      username: "deandu",
      password: "3t1415926",
      unit: 2,
      id: 1,
      propertyname: "Greenwood Apartments",
      leasestart: DateTime(2022, 1, 15),
      leaseend: DateTime(2023, 1, 14),
      isloggedin: false),
  Resident(
      username: "johndoe",
      password: "password1",
      unit: 3,
      id: 2,
      propertyname: "Palm Villas",
      leasestart: DateTime(2022, 2, 20),
      leaseend: DateTime(2023, 2, 19),
      isloggedin: false),
  Resident(
      username: "janedoe",
      password: "password2",
      unit: 4,
      id: 3,
      propertyname: "Ocean View Apartments",
      leasestart: DateTime(2022, 3, 10),
      leaseend: DateTime(2023, 3, 9),
      isloggedin: false),
  Resident(
      username: "mike91",
      password: "password3",
      unit: 5,
      id: 4,
      propertyname: "City Lights Condos",
      leasestart: DateTime(2022, 5, 15),
      leaseend: DateTime(2023, 5, 14),
      isloggedin: false),
  Resident(
      username: "sarah89",
      password: "password4",
      unit: 10,
      id: 5,
      propertyname: "Greenwood Apartments",
      leasestart: DateTime(2022, 6, 1),
      leaseend: DateTime(2023, 5, 31),
      isloggedin: false),
  Resident(
      username: "roberto23",
      password: "password5",
      unit: 12,
      id: 6,
      propertyname: "Palm Villas",
      leasestart: DateTime(2022, 7, 12),
      leaseend: DateTime(2023, 7, 11),
      isloggedin: false),
  Resident(
      username: "claire56",
      password: "password6",
      unit: 7,
      id: 7,
      propertyname: "Ocean View Apartments",
      leasestart: DateTime(2022, 8, 8),
      leaseend: DateTime(2023, 8, 7),
      isloggedin: false),
  Resident(
      username: "alex45",
      password: "password7",
      unit: 15,
      id: 8,
      propertyname: "City Lights Condos",
      leasestart: DateTime(2022, 9, 20),
      leaseend: DateTime(2023, 9, 19),
      isloggedin: false),
  Resident(
      username: "lucia78",
      password: "password8",
      unit: 16,
      id: 9,
      propertyname: "Greenwood Apartments",
      leasestart: DateTime(2022, 10, 3),
      leaseend: DateTime(2023, 10, 2),
      isloggedin: false),
  Resident(
      username: "mark67",
      password: "password9",
      unit: 9,
      id: 10,
      propertyname: "Palm Villas",
      leasestart: DateTime(2022, 11, 25),
      leaseend: DateTime(2023, 11, 24),
      isloggedin: false),
];
