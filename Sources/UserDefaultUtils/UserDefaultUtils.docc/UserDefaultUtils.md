# ``UserDefaultUtils``

@Metadata {
  @PageImage(purpose: icon, source: "userdefaultutils-icon", alt: "swift-userdefault logo")
  @PageColor(red)
}

Store optional RawRepresentable values through UserDefault.

## Overview

Import this module to use its `Optional` conformance to `RawRepresentable`.
It re-exports UserDefault, so optional enumerations can use raw-value storage
with the same property wrapper. A `nil` assignment removes the stored key;
subsequent reads return the property's declared default.

See the [package usage guide](https://github.com/swift-library/swift-userdefault/blob/master/README.md)
for installation and complete examples.
