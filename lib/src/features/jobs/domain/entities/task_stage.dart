enum TaskStage {
  slabDown("Slab Down"),
  plateHeigh("Plate Heigh"),
  roofCover("Roof cover"),
  lockUp("Lock Up"),
  cabinets("Cabinets"),
  pCI("PCI");

  final String name;

  const TaskStage(this.name);

  @override
  String toString() => name;

  String toJSON() => name.toUpperCase().replaceAll(' ', '_');

  static TaskStage fromString(String str) {
    switch (str.toLowerCase()) {
      case "slab_down":
        return TaskStage.slabDown;
      case "plate_height":
        return TaskStage.plateHeigh;
      case "roof_cover":
        return TaskStage.roofCover;
      case "lock_up":
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
