class HealthResponse {
  final String status;
  final String application;
  final String version;
  final String timestamp;

  const HealthResponse({
    required this.status,
    required this.application,
    required this.version,
    required this.timestamp,
  });

  factory HealthResponse.fromJson(Map<String, dynamic> json) {
    return HealthResponse(
      status: json['status'] ?? 'UNKNOWN',
      application: json['application'] ?? '',
      version: json['version'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}