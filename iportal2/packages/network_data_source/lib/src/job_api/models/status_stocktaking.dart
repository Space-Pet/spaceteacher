class StatusStocktaking {
  final int status;
  const StatusStocktaking({required this.status});
  factory StatusStocktaking.fromMap(Map<String, dynamic> map){
    return StatusStocktaking(status: map['status'] ?? 0);
  }
}