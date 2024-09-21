enum FCMOption {
  target,
  customData,
  additionalOption,
}

extension FCMOptionExtension on FCMOption {
  int get index {
    switch (this) {
      case FCMOption.target:
        return 0;
      case FCMOption.customData:
        return 1;
      case FCMOption.additionalOption:
        return 2;
      default:
        return 0;
    }
  }
}
