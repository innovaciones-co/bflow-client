class JobEntity {
  // ...
  // An entity represents a real-world object with a distinct identity.
  final int id;
  final String jobNumber;
  final String name;
  final DateTime plannedStartDate;
  final DateTime plannedEndDate;
  final String address;
  final String? contract;
  final String? description;
  final BuildingType buildingType;

  JobEntity({
    required this.id,
    required this.jobNumber,
    required this.name,
    required this.plannedStartDate,
    required this.plannedEndDate,
    required this.address,
    this.contract,
    this.description,
    required this.buildingType,
  });
}

enum BuildingType {
  doubleStorey,
  singleStorey,
  shop,
  renovation,
  extension,
}
