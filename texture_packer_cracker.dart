#!/usr/bin/env dart --enable_type_checks --enable_asserts

#import('package:dart-xml/xml.dart');
#import('dart:io');
#import('dart:math');
#import('../dartlib/lib/dartlib.dart');

const String _path =
@"./html/canvas/art.plist";

main(){

  final path = new Path(_path);
  final file = new File.fromPath(path);
  final docString = file.readAsTextSync();

  final doc = XML.parse(docString);

  var rootDict = $(doc.children).first();
  final hashMap = _parseDict(rootDict);
  print(hashMap);
}

HashMap<String, Dynamic> _parseDict(XmlElement element) {
  assert(element != null);
  assert(element.name == "dict");

  final children = $(element.children).toList();
  assert(children.length %2 == 0);

  final map = <String,Dynamic>{};
  for(int i= 0; i < children.length; i+=2) {
    final keyElement = children[i];
    assert(keyElement.name == 'key');
    final key = keyElement.text;

    final valueElement = children[i+1];
    final value = _parseValue(valueElement);

    map[key] = value;
  }

  return map;
}

Dynamic _parseValue(XmlElement element) {
  assert(element != null);
  switch(element.name) {
    case 'string':
      return element.text;
    case 'dict' :
      return _parseDict(element);
    case 'false' :
      return false;
    case 'true':
      return true;
    case 'integer':
      return parseInt(element.text);
    default:
      throw "support for ${element.name} has not implemented";
  }
}