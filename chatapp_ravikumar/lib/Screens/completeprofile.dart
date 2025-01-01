// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Completeprofile extends StatefulWidget {
//   const Completeprofile({Key? key}) : super(key: key);

//   @override
//   _CompleteprofileState createState() => _CompleteprofileState();
// }

// class _CompleteprofileState extends State<Completeprofile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text("Complete Profile",style: 
//         TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//         backgroundColor: Color.fromARGB(223, 13, 197, 230),
//       ),
//       body: SafeArea(
//         child:Container(
//           padding: EdgeInsets.symmetric(horizontal: 40),
//           child: ListView(
//             children: [
//               SizedBox(height: 20,),
//               CircleAvatar(
//                 radius: 60,
//                 child: Icon(Icons.person,size:60,),
//               ),
//               SizedBox(height: 20,),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: "Full Name"
//                 ),
//               ),
//               SizedBox(height: 20,),

//               CupertinoButton(child: Text("Submit"), onPressed:(){},
//               color: Color.fromARGB(202, 12, 207, 214),),
//             ],
//           ),
//         ) ),
//     );
//   }
// }
