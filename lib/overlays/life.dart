import 'package:flutter/material.dart';
import 'package:spacex/main.dart';
class Life extends StatelessWidget {

  static const String ID='Life';
  final SpaceGame gameRef;
  const Life({Key? key,required this.gameRef}) : super(key: key);

  Widget heart()
  {
    List<Widget> arr=[];
    for(int i=0;i<int.parse(gameRef.lives.toString())+1;i++)
    {
      arr.add(Icon(Icons.favorite,size: 40,color: Colors.red,));
    }
    return Row(
      children:arr.map((e) => e).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child:heart(),
    );
  }
}
