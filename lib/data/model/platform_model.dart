class Buy {
  String logoPath;
  int providerId;
  String providerName;
  int displayPriority;

  Buy({
    required this.logoPath,
    required this.providerId,
    required this.providerName,
    required this.displayPriority,
  });

  factory Buy.fromJson(Map<String, dynamic> json) => Buy(
        logoPath: json["logo_path"] ?? "",
        providerId: json["provider_id"],
        providerName: json["provider_name"] ?? "",
        displayPriority: json["display_priority"],
      );

  Map<String, dynamic> toJson() => {
        "logo_path": logoPath,
        "provider_id": providerId,
        "provider_name": providerName,
        "display_priority": displayPriority,
      };
}
