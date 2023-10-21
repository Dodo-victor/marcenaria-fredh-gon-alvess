import 'package:flutter/cupertino.dart';
import 'package:fredh_lda/models/merchandise.dart';
import 'package:fredh_lda/models/userModel.dart';

class RequestProductModel {
  final UserModel user;
  final MerchandiseModel product;
  final String id;

  final bool isRequested;
  final String userUid;

  RequestProductModel({
    required this.user,
    required this.id,
    required this.isRequested,
    required this.userUid,
    required this.product,
  });

  toMap() {
    return {
      "nome": user.name,
      "id": id,
      "idUsuario": userUid,
      "produtoNome": product.name,
      "estaSolicitando": isRequested,
      "descrição": product.descr,
      "medida": product.size,
      "tipoMadeira": product.woodType,
      "preço": product.price,
      "foto": product.photoUrl,
      "data": DateTime.now(),
    };
  }

  static fromMap(map) {
    return {
      "nome": map["nome"] ?? '',
      "id": map["id"] ?? '',
      "idUsuario": map["idUsuario"] ?? '',
      "produtoNome": map["produtoNome"] ?? '',
      "estaSolicitando": map["estaSolicitando"] ?? '',
      "preço": map["preço"] ?? '',
      "foto": map["foto"] ?? '',
      "data": DateTime.now(),
    };
  }
}
