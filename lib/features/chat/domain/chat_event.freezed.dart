// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ChatEvent()';
}


}

/// @nodoc
class $ChatEventCopyWith<$Res>  {
$ChatEventCopyWith(ChatEvent _, $Res Function(ChatEvent) __);
}


/// Adds pattern-matching-related methods to [ChatEvent].
extension ChatEventPatterns on ChatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatMessageReceived value)?  message,TResult Function( ChatPresenceChanged value)?  presence,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatMessageReceived() when message != null:
return message(_that);case ChatPresenceChanged() when presence != null:
return presence(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatMessageReceived value)  message,required TResult Function( ChatPresenceChanged value)  presence,}){
final _that = this;
switch (_that) {
case ChatMessageReceived():
return message(_that);case ChatPresenceChanged():
return presence(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatMessageReceived value)?  message,TResult? Function( ChatPresenceChanged value)?  presence,}){
final _that = this;
switch (_that) {
case ChatMessageReceived() when message != null:
return message(_that);case ChatPresenceChanged() when presence != null:
return presence(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ChatMessage message)?  message,TResult Function( int online)?  presence,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatMessageReceived() when message != null:
return message(_that.message);case ChatPresenceChanged() when presence != null:
return presence(_that.online);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ChatMessage message)  message,required TResult Function( int online)  presence,}) {final _that = this;
switch (_that) {
case ChatMessageReceived():
return message(_that.message);case ChatPresenceChanged():
return presence(_that.online);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ChatMessage message)?  message,TResult? Function( int online)?  presence,}) {final _that = this;
switch (_that) {
case ChatMessageReceived() when message != null:
return message(_that.message);case ChatPresenceChanged() when presence != null:
return presence(_that.online);case _:
  return null;

}
}

}

/// @nodoc


class ChatMessageReceived implements ChatEvent {
  const ChatMessageReceived(this.message);
  

 final  ChatMessage message;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageReceivedCopyWith<ChatMessageReceived> get copyWith => _$ChatMessageReceivedCopyWithImpl<ChatMessageReceived>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageReceived&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'ChatEvent.message(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatMessageReceivedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatMessageReceivedCopyWith(ChatMessageReceived value, $Res Function(ChatMessageReceived) _then) = _$ChatMessageReceivedCopyWithImpl;
@useResult
$Res call({
 ChatMessage message
});


$ChatMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ChatMessageReceivedCopyWithImpl<$Res>
    implements $ChatMessageReceivedCopyWith<$Res> {
  _$ChatMessageReceivedCopyWithImpl(this._self, this._then);

  final ChatMessageReceived _self;
  final $Res Function(ChatMessageReceived) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChatMessageReceived(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ChatMessage,
  ));
}

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<$Res> get message {
  
  return $ChatMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class ChatPresenceChanged implements ChatEvent {
  const ChatPresenceChanged(this.online);
  

 final  int online;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPresenceChangedCopyWith<ChatPresenceChanged> get copyWith => _$ChatPresenceChangedCopyWithImpl<ChatPresenceChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPresenceChanged&&(identical(other.online, online) || other.online == online));
}


@override
int get hashCode {
    return Object.hash(runtimeType,online);
}

@override
String toString() {
    return 'ChatEvent.presence(online: $online)';
}


}

/// @nodoc
abstract mixin class $ChatPresenceChangedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatPresenceChangedCopyWith(ChatPresenceChanged value, $Res Function(ChatPresenceChanged) _then) = _$ChatPresenceChangedCopyWithImpl;
@useResult
$Res call({
 int online
});




}
/// @nodoc
class _$ChatPresenceChangedCopyWithImpl<$Res>
    implements $ChatPresenceChangedCopyWith<$Res> {
  _$ChatPresenceChangedCopyWithImpl(this._self, this._then);

  final ChatPresenceChanged _self;
  final $Res Function(ChatPresenceChanged) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? online = null,}) {
  return _then(ChatPresenceChanged(
null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
