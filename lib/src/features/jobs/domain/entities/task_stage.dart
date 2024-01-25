enum TaskStage {
  slabDown("Slab Down"),
  plateHeigh("Plate Heigh"),
  roofCover("Roof cover"),
  lockUp("Lock Up"),
  cabinets("Cabinates"),
  pCI("PCI");

  final String name;

  const TaskStage(this.name);

  @override
  String toString() => name;

  String toJSON() => name.toUpperCase().replaceAll(' ', '_');

  static TaskStage fromString(String str) {
    switch (str.toLowerCase()) {
      case "slab down":
        return TaskStage.slabDown;
      case "plate height":
        return TaskStage.plateHeigh;
      case "roof cover":
        return TaskStage.roofCover;
      case "lock up":
        return TaskStage.lockUp;
      case "cabinets":
        return TaskStage.cabinets;
      case "pci":
        return TaskStage.pCI;
      default:
        return TaskStage
            .slabDown; // Default to SLAB_DOWN if the input is not recognized
    }
  }
}
