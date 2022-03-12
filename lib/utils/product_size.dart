enum ProductSize { small, medium, large, unknown }

extension Stringify on ProductSize {
  String toJson() {
    switch (this) {
      case ProductSize.small:
        return 'sm';
      case ProductSize.medium:
        return 'md';
      case ProductSize.large:
        return 'lg';
      case ProductSize.unknown:
        return 'default';
    }
  }

  ProductSize fromJson() {
    return ProductSize.unknown;
  }

  ProductSize fromString(String size) {
    if (size.toLowerCase() == 'large') {
      return ProductSize.large;
    } else if (size.toLowerCase() == 'medium') {
      return ProductSize.medium;
    } else if (size.toLowerCase() == 'small') {
      return ProductSize.small;
    } else {
      return ProductSize.unknown;
    }
  }
}

String productSizeToString(ProductSize size) {
  switch (size) {
    case ProductSize.small:
      return 'sm';
    case ProductSize.medium:
      return 'md';
    case ProductSize.large:
      return 'lg';
    case ProductSize.unknown:
      return 'default';
  }
}

ProductSize productFromString(String size) {
  if (size.toLowerCase() == 'large') {
    return ProductSize.large;
  } else if (size.toLowerCase() == 'medium') {
    return ProductSize.medium;
  } else if (size.toLowerCase() == 'small') {
    return ProductSize.small;
  } else {
    return ProductSize.unknown;
  }
}
