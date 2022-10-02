import 'package:chantech/consts.dart';

bool? IsAdmin;
bool? IsOuvrier;
bool? IsProp;
bool? IsResp;
String? emailGlob;
int? idGlob;
String urlResponsable = localhost + 'ouvrier/idOuvrier/$idGlob/responsable';
String urlProp = localhost + 'ouvrier/idPersonne/$idGlob/proprietaire';
String urlOuv = localhost + 'ouvrier/idOuvrier/$idGlob/affecter';
