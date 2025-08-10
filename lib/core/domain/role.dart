import 'package:freezed_annotation/freezed_annotation.dart';
import 'alignment.dart';
part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class Role with _$Role {
  const factory Role({
    required String id,            // unique key (e.g., 'citizen')
    required String name,          // display name (EN for now)
    required AlignmentType align,  // faction
    String? description,           // short ability text (TBD)
    @Default([]) List<String> tags,
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}