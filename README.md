# ekar demo app

## Features
- Built using SwiftUI and Combine framwork
- MVVM arch pattern
- Protocol oriented programming
- Use struct instead of class for models, to ensure immutability
- Coordinators as delegates for legacy UIKit framworks (Map and PickerView)

## Arch layers

![Untitled drawing](https://user-images.githubusercontent.com/1952395/126899596-3ca86eb0-0709-4e2b-8542-3e8c46d69f81.png)

## Improvements
- Decouple Navigation from the view
- Cache in an external service instead of in the same class to guarantee cohesion (single responsability principle)
- Use Dependency injection framework to reduce coupling
- Inline error messages upon submitting form
- Unit testing for network / repositories
