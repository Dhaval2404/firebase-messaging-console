enum FCMOption {
  target,
  custom_data,
  additional_option,
}

extension FCMOptionExtension on FCMOption {
  int get index {
    switch (this) {
      case FCMOption.custom_data:
        return 1;
      case FCMOption.additional_option:
        return 2;
      case FCMOption.target:
      default:
        return 0;
    }
  }

}
