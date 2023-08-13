class Normal {
  const Normal(this.text, this.confidence);
  final String text;
  final double confidence;

  factory Normal.fromJson(Map<String, Object> json) =>
      Normal(json['text'] as String, json['confidence'] as double);

  @override
  String toString() => 'Text: $text, confidence:$confidence';
}
