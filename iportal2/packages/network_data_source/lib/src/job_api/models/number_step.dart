//Số lượng thùng đã quét
class NumberStep {
  final int step1;
  final int step2;
  final int step3;
  final int step4;
  final int step5;
  const NumberStep({
    required this.step1,
    required this.step2,
    required this.step3,
    required this.step4,
    required this.step5
});
  factory NumberStep.fromMap(Map<String, dynamic> map){
    return NumberStep(
        step1: map['1001'],
        step2: map['1002'],
        step3: map['1003'],
        step4: map['1004'],
        step5: map['1005'],
    );
  }
}