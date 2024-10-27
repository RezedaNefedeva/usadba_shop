import 'package:equatable/equatable.dart';
import 'package:firebase_app/entities/entities.dart';

class MyUser extends Equatable{
  final String id;
  final String name;
  final String phone;
  final String email;


  const MyUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.email});

  static const empty = MyUser(
      id: '',
      name: '',
      phone: '',
      email: '');

  MyUser copyWith({
    String? id,
    String? name,
    String? phone,
    String? email
}){
    return MyUser (
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email
    );
  }

  bool get isEmpty => this == MyUser.empty;

  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity(){
    return MyUserEntity(
      id: id,
      name: name,
      phone: phone,
      email: email,
    );
  }

  static MyUser fromEntity(MyUserEntity entity){
    return MyUser(
      id: entity.id,
      name: entity.name,
      phone: entity.phone,
      email: entity.email
    );
}

  @override
  List<Object?> get props => [id, name, phone, email];

}