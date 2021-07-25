# ekar demo app

## Features
- Build using SwiftUI and Combine framwork
- MVVM arch pattern
- Protocol oriented programming
- Use struct instead of class for models, to ensure immutability
- Coordinators as delegates for legacy UIKit framworks (Map and PickerView)

## Improvements
- Decouple Navigation from the view
- Cache in an external service instead of in the same class to guarantee cohesion (single responsability principle)
- Use Dependency injection framework to reduce coupling
- Inline error messages upon submitting form
- Unit testing for network / repositories
