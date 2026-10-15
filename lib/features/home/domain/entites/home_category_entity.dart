class HomeCategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String creationAt;
  final String updatedAt;

  const HomeCategoryEntity({
    this.id = 0,
    this.name = '',
    this.slug = '',
    this.image = '',
    this.creationAt = '',
    this.updatedAt = '',
  });
}
