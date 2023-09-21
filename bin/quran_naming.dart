import 'dart:convert';
import 'dart:io';
void main(List<String> arguments) async{

  final String format='.mp3';
  final List<FileSystemEntity> entities=await getFiles('D:\\قرآن\\حصري مرتل');
  final List<String> names=await getNames("assets/فهرس.txt");

  assert(names.length == entities.length,"names is ${names.length}, while audios is ${entities.length}");

  for(int i=0;i<names.length;i++){
  entities[i].rename(entities[i].parent.path+'\\'+names[i]+format);
  }

  print("Done");
}

Future<List<FileSystemEntity>> getFiles(String path)async{
  List<FileSystemEntity>  entities=[];
  try{
    // read quran files PATH
    final dir = Directory(path);
 entities = await dir.list().toList();
  }catch(e){
    print("error getting entities for path $path : $e");
  }

    return Future.value(entities);
}

Future<List<String>> getNames(String path)async{
  List<String> names=[];
  try{
    // read text
    names=await File("assets/فهرس.txt")
        .openRead()
        .transform(utf8.decoder)
        .transform(LineSplitter()).toList();
  }catch(e){
    print("error getting names for path $path : $e");
  }

    return names;
}