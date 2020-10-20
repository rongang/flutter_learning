


import 'dart:core';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
class AnoTest{
  final String name;
  final int id;
  final String rune;
  static final Runes runes = Runes('\u{1f37f}');
  const AnoTest(this.name,this.id, {this.rune});
}
@AnoTest('one',1)
class TestAno{
  int age = 20;
}

class TestGenerator extends GeneratorForAnnotation<AnoTest>{
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    var content  ='''
    element:$element,
    element.metadata:${element.metadata[0]},
    element.declaration:${element.declaration},
    element.library:${element.library},
    element.enclosingElement:${element.enclosingElement},
    annotation:$annotation,
    buildStep:$buildStep,
    annotation.read('name'):${annotation.read('name')},
    annotation.read('id')${annotation.read('id')},
    annotation.read('runes')${annotation.read('runes')},
    buildStep.runtimeType: ${buildStep.runtimeType},
    buildStep.inputId.path: ${buildStep.inputId.path},
    buildStep.inputId.extension: ${buildStep.inputId.extension},
    buildStep.inputId.package: ${buildStep.inputId.package},
    buildStep.inputId.uri: ${buildStep.inputId.uri},
    buildStep.inputId.pathSegments: ${buildStep.inputId.pathSegments},
    ''';
    // element.
    String name = annotation.read('name').stringValue;
    int id =  annotation.read('id').intValue;
    Runes runes = annotation.peek('field')?.objectValue as Runes;
    print('--------');
    print(content);
    return '''
    class ${element.name}APT{
      String name = '$name';
      int id = $id;
      Runes runes = $runes;
      }
    ''';
  }

}
Builder testBuilder(BuilderOptions options) =>
    LibraryBuilder(TestGenerator());
