import '../../domain/entities/lung_percentage.dart';
import '../platform_channel/platform.dart';

Future<LungPercentage> runLungModel(String imagePath) async {
  final List<double> output = await MyPlatform().runLung(imagePath);
  double maximumPercentage = 0.0;
  int maxIndex = 0;
  for (int i = 0; i < output.length; i++) {
    if (output[i] >= maximumPercentage) {
      maximumPercentage = output[i];
      maxIndex = i;
    }
  }
  return LungPercentage(name: names[maxIndex], percentage: maximumPercentage);
}

final names = [
  'Adenocarcinoma',
  'BenignTissue',
  'SquamousCarcinoma',
];
