enum TaskStage {
  SLAB_DOWN("Slab Down"),
  PLATE_HEIGH("Plate Heigh"),
  ROOF_COVER("Roof cover"),
  LOCK_UP("Lock Up"),
  CABINETS("Cabinates"),
  PCI("PCI");

  final String name;
  const TaskStage(this.name);

  @override
  String toString() => name;

  static TaskStage fromString(String str) {
    switch (str.toLowerCase()) {
      case "slab down":
        return TaskStage.SLAB_DOWN;
      case "plate height":
        return TaskStage.PLATE_HEIGH;
      case "roof cover":
        return TaskStage.ROOF_COVER;
      case "lock up":
        return TaskStage.LOCK_UP;
      case "cabinets":
        return TaskStage.CABINETS;
      case "pci":
        return TaskStage.PCI;
      default:
        return TaskStage
            .SLAB_DOWN; // Default to SLAB_DOWN if the input is not recognized
    }
  }
}
