import 'package:flutter/cupertino.dart';

class Hello extends StatelessWidget {
  const Hello({super.key});
static const routeName = '/hello';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('hello word'),
    );
  }
}
