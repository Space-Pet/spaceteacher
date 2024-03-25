class NumberStepInventory {
  final int data;
  const NumberStepInventory({
    required this.data
});
  factory NumberStepInventory.fromMap(Map<String, dynamic> map){
    return NumberStepInventory(
        data: map['data']
    );
  }
}