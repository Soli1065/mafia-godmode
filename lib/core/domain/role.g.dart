// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoleImpl _$$RoleImplFromJson(Map<String, dynamic> json) => _$RoleImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      align: $enumDecode(_$AlignmentTypeEnumMap, json['align']),
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$RoleImplToJson(_$RoleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'align': _$AlignmentTypeEnumMap[instance.align]!,
      'description': instance.description,
      'tags': instance.tags,
    };

const _$AlignmentTypeEnumMap = {
  AlignmentType.citizen: 'citizen',
  AlignmentType.mafia: 'mafia',
  AlignmentType.independent: 'independent',
};
