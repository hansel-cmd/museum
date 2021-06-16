
class Property {
  final String title;
  final String objectName;
  final String department;
  final String accessionYear;
  final String city;
  final String country;
  final String primaryImage;
  final String primaryImageSmall;
  final List additionalImages;
  final bool isPublicDomain; // other
  final bool isHighlight; // liked

  Property({
    this.title,
    this.objectName,
    this.department,
    this.accessionYear,
    this.city,
    this.country,
    this.primaryImage,
    this.primaryImageSmall,
    this.additionalImages,
    this.isPublicDomain,
    this.isHighlight,
  });
}
