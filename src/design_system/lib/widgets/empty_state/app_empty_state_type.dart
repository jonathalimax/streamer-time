enum AppEmptyStateType {
  error,
  noImage,
  noDocument,
  noSearchResult,
}

extension EmptyStateTypeAsset on AppEmptyStateType {
  String get path {
    switch (this) {
      case AppEmptyStateType.error:
        return 'lib/resources/images/error.png';
      case AppEmptyStateType.noImage:
        return 'lib/resources/images/no-images.png';
      case AppEmptyStateType.noDocument:
        return 'lib/resources/images/no-documents.png';
      case AppEmptyStateType.noSearchResult:
        return 'lib/resources/images/no-search-results.png';
    }
  }
}
