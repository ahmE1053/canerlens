import '../../core/utilities/specialties_map.dart';

class MedicalSpecialties {
  final String simpleName, complexName, imagePath;
  const MedicalSpecialties(this.complexName, this.simpleName, this.imagePath);
  factory MedicalSpecialties.fromName(String name) {
    return specialties.where((element) => element.complexName == name).first;
  }
  factory MedicalSpecialties.fromSpeciality(String specialty) {
    return specialties
        .where((element) => element.complexName == specialty)
        .first;
  }
}
