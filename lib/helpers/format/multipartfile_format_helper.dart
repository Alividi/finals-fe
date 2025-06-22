import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';

Future<MultipartFile> fileToMultipart(File file) async {
  final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
  return MultipartFile.fromFile(
    file.path,
    filename: file.path.split('/').last,
    contentType: MediaType.parse(mimeType),
  );
}
