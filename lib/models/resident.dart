class Resident {
  final String name;
  final String unit;
  final String id;
  final String propertyname;
  final String address;
  final DateTime leasestart;
  final DateTime leaseend;
  final int monthlyRent;
  final DateTime rentDueDate;
  final int deposit;
  final int petRent;
  final DateTime lastCall;

  Resident({
    required this.name,
    required this.unit,
    required this.id,
    required this.propertyname,
    required this.address,
    required this.leasestart,
    required this.leaseend,
    required this.monthlyRent,
    required this.rentDueDate,
    required this.deposit,
    required this.petRent,
    required this.lastCall,
  });
}
