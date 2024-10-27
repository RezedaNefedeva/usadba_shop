import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable{

  final String id;
  final String name;
  final String phone;
  final String email;


  const MyUserEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.email});

  Map<String, Object?> toDocument(){
    return {
      'id' : id,
      'name' : name,
      'phone' : phone,
      'email' : email
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc){
    return MyUserEntity(
      id: doc['id'] as String,
      name: doc['name'] as String,
      phone: doc['phone'] as String,
      email: doc['email'] as String
    );
  }

  @override
  List<Object?> get props => [id, name, phone, email];

  @override
  String toString() {
    return '''MyUserEntity: {
    id - $id,
    name - $name,
    phone - $phone,
    email - $email
    }''';
  }

}