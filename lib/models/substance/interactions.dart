import 'package:json_annotation/json_annotation.dart';

part 'interactions.g.dart';

@JsonSerializable()
class Interactions {
  final List<String> dangerous;
  final List<String> unsafe;
  final List<String> uncertain;

  Interactions({
    required this.dangerous,
    required this.unsafe,
    required this.uncertain,
  });

  factory Interactions.fromJson(Map<String, dynamic> json) => _$InteractionsFromJson(json);
  Map<String, dynamic> toJson() => _$InteractionsToJson(this);
}
