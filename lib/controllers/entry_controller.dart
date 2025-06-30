import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/entries_service.dart';

class EntryController{

  static final  entryController = EntryController();

  Future<String?> createEntry({
    required String text,
    required String pid,
    required String feeling,

}) async{
    final uid= authService.value.currentUser!.uid;

    if( text.isEmpty){
      return "please fill all the information";
    }
    try{
      await entryService.value.createNewEntry(uid: uid, pid: pid, text: text, feeling: feeling);
      return null;
    }catch (e){
      return "error : $e";
    }
  }
}