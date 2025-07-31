

import 'dart:io';

import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/person_service.dart';

class PersonController{
 static final personController = PersonController();

 Future<String?> createPerson({
   required String name,
   required String gender,
   required String intro,
   required File picture
})async{
   final uid= authService.value.currentUser!.uid;
   if (name.isEmpty || gender.isEmpty || intro.isEmpty){
     return "please fill all the information";

   }
   try{
   await personService.value.createNewPerson(uid: uid, name: name, gender: gender, intro: intro,personPicture:picture );
   return null;
   }catch (e){
     print(e);
     return "error $e";
   }
 }
 Future<String?> deleteThisPerson({
   required String uid,
   required String pid
}) async{
   try{
     await personService.value.deletePerson(uid: uid, pid: pid);
     return null;
   }catch (e){
     return "there was an error ${e.toString()}";
   }
 }


}