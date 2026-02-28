class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.thecatapi.com/';
  static const String breedsPath = 'v1/breeds';

  static String imageUrl(String imageId) =>
      'https://cdn2.thecatapi.com/images/$imageId.jpg';
}
