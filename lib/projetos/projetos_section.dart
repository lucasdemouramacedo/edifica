import 'package:flutter/material.dart';

class ProjetosSection extends StatelessWidget {
  const ProjetosSection({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.73,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: Text('Projetos'),
      ),
    );
  }
}