enum FCMOption {
  target,
  customData,
  additionalOption,
}

extension FCMOptionExtension on FCMOption {
  int get index {
    switch (this) {
      case FCMOption.customData:
        return 1;
      case FCMOption.additionalOption:
        return 2;
      case FCMOption.target:
      default:
        return 0;
    }
  }
}
