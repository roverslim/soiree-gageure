[![CircleCI](https://circleci.com/gh/roverslim/soiree-gageure.svg?style=svg&circle-token=9f7a0f8200d837a4ec4bfb9ada4447f0a3ff4566)](https://circleci.com/gh/roverslim/soiree-gageure)

# Contribution guidelines on code architecture

Controllers actions need to be devoid of business logic and devoid of conditional logic. Simple actions are easier to reason about. A controller is responsible for channeling data to the view.

Views must be free of all conditional logic. HTML mixed with ruby is difficult to maintain. Testing a view results in verifying it is rendered for a given action.

The use of serializers is preferred when returning JSON. It allows to isolate the attributes exposed by API from the controller.
