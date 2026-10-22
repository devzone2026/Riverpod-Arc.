// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatSettings {

/// Stable anonymous id for this install (tells "my" messages apart).
 String get userId; String get username; String get serverUrl;
/// Create a copy of ChatSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSettingsCopyWith<ChatSettings> get copyWith => _$ChatSettingsCopyWithImpl<ChatSettings>(this as ChatSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSettings&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.serverUrl, _this.serverUrl) || other.serverUrl == _this.serverUrl));
}


@override
int get hashCode {
  final _this = this as ChatSettings;
  return Object.hash(runtimeType,_this.userId,_this.username,_this.serverUrl);
}

@override
String toString() {
  final _this = this as ChatSettings;
  return 'ChatSettings(userId: ${_this.userId}, username: ${_this.username}, serverUrl: ${_this.serverUrl})';
}


}

/// @nodoc
abstract mixin class $ChatSettingsCopyWith<$Res>  {
  factory $ChatSettingsCopyWith(ChatSettings value, $Res Function(ChatSettings) _then) = _$ChatSettingsCopyWithImpl;
@useResult
$Res call({
 String userId, String username, String serverUrl
});




}
/// @nodoc
class _$ChatSettingsCopyWithImpl<$Res>
    implements $ChatSettingsCopyWith<$Res> {
  _$ChatSettingsCopyWithImpl(this._self, this._then);

  final ChatSettings _self;
  final $Res Function(ChatSettings) _then;

/// Create a copy of ChatSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,Object? serverUrl = null,}) {
  return _then(ChatSettings(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,serverUrl: null == serverUrl ? _self.serverUrl : serverUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatSettings].
extension ChatSettingsPatterns on ChatSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatSettings value)  $default,){
final _that = this;
switch (_that) {
case _ChatSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ChatSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String username,  String serverUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatSettings() when $default != null:
return $default(_that.userId,_that.username,_that.serverUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String username,  String serverUrl)  $default,) {final _that = this;
switch (_that) {
case _ChatSettings():
return $default(_that.userId,_that.username,_that.serverUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String username,  String serverUrl)?  $default,) {final _that = this;
switch (_that) {
case _ChatSettings() when $default != null:
return $default(_that.userId,_that.username,_that.serverUrl);case _:
  return null;

}
}

}

/// @nodoc


class _ChatSettings implements ChatSettings {
  const _ChatSettings({required this.userId, required this.username, required this.serverUrl});
  

/// Stable anonymous id for this install (tells "my" messages apart).
@override final  String userId;
@override final  String username;
@override final  String serverUrl;

/// Create a copy of ChatSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatSettingsCopyWith<_ChatSettings> get copyWith => __$ChatSettingsCopyWithImpl<_ChatSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatSettings&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.serverUrl, serverUrl) || other.serverUrl == serverUrl));
}


@override
int get hashCode {
    return Object.hash(runtimeType,userId,username,serverUrl);
}

@override
String toString() {
    return 'ChatSettings(userId: $userId, username: $username, serverUrl: $serverUrl)';
}


}

/// @nodoc
abstract mixin class _$ChatSettingsCopyWith<$Res> implements $ChatSettingsCopyWith<$Res> {
  factory _$ChatSettingsCopyWith(_ChatSettings value, $Res Function(_ChatSettings) _then) = __$ChatSettingsCopyWithImpl;
@override @useResult
$Res call({
 String userId, String username, String serverUrl
});




}
/// @nodoc
class __$ChatSettingsCopyWithImpl<$Res>
    implements _$ChatSettingsCopyWith<$Res> {
  __$ChatSettingsCopyWithImpl(this._self, this._then);

  final _ChatSettings _self;
  final $Res Function(_ChatSettings) _then;

/// Create a copy of ChatSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? serverUrl = null,}) {
  return _then(_ChatSettings(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,serverUrl: null == serverUrl ? _self.serverUrl : serverUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
