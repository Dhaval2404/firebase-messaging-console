enum ConsoleTabMenu {
  target,
  customData,
  additionalOption,
}

extension ConsoleTabMenuExtension on ConsoleTabMenu {
  int get index {
    switch (this) {
      case ConsoleTabMenu.target:
        return 0;
      case ConsoleTabMenu.customData:
        return 1;
      case ConsoleTabMenu.additionalOption:
        return 2;
      default:
        return 0;
    }
  }
}
