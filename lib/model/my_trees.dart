import 'my_tree.dart';

class MyTrees {
  MyTrees(
      {
        this.trees,
        this.sasToken,
      });

  factory MyTrees.fromJson(Map<String, dynamic> json) {
    final String? token = json['sasToken'] as String?;
    final List<dynamic> trees = json['trees'] as List<dynamic>;
    final List<MyTree> parsedTrees =  trees.map((dynamic json) => MyTree.fromJson(json, token)).toList();


    return MyTrees(
        trees: parsedTrees,
        sasToken: token);
  }

  final List<MyTree>? trees;
  final String? sasToken;
}
