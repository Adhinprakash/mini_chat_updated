import 'package:flutter/material.dart';
import 'package:minichat/utils/consts.dart';

class Usertile extends StatelessWidget {
  const Usertile({super.key, this.ontap, required this.text});
 final String text;
final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      
      child: GestureDetector
      (
        onTap: ontap,
        child: Container(

        
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12)
            
                  ),
          child:  Row(
        children: [
          Icon(Icons.person,size: 50,),
        kwidhth20,
          Text(text)
        ],
        
          ),
        ),
      ),
    );
  }
}