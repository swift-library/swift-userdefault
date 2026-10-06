# ``UserDefault``

@Metadata {
  @PageImage(purpose: icon, source: "userdefault-icon", alt: "swift-userdefault logo")
  @PageColor(red)
}

Store Swift properties in UserDefaults with a property wrapper.

## Overview

``UserDefault`` selects direct, raw-value or JSON storage from the property
type. Reads return the declared default when the stored value cannot be read
as that type. Assigning `nil` to an optional property removes its key.

## Topics

### Property storage

- ``UserDefault``
- ``UserDefaultWrapper``

See the [package usage guide](https://github.com/swift-library/swift-userdefault/blob/master/README.md)
for installation and complete examples.
