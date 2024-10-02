# DataPopulationChallenge

What was used: 
Swift with UIKit
MVVM

Regarding the project:
I used a tab controller one for state and other for nation.
I could had used another approach with a button on the navigation bar to switch between state and nations but I also was thinking that in the future for example could have more nations so it would make sense to keep in a separate view.

For Improvements:
The use of SwiftUI with combine for better and updated code/technology

Regarding the network handling:
-An enum for the different errors messages
-The request functions to have more parameters on the completionHandler, for example 
	(_ success: Bool, _ data: [Any], _ error: String?)