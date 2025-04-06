🍽️ Food Mingle Restaurants
Food Mingle Restaurants is a Swift-based application that retrieves restaurant data from the Just Eat API based on a user-provided postcode. The app then displays a curated list of restaurants—showing their name, cuisines, rating (as a number), and address—in a modern, visually appealing SwiftUI interface.

🚀 The Problem
We needed to build an application that:

Fetches restaurant data from the Just Eat API using a postcode.

Filters the data to display only the following key details:

Name

Cuisines

Rating (as a number)

Address

Limits the display to the first 10 restaurants returned.

📋 The Brief
Interface:
Use any interface of your choice. This solution uses SwiftUI to create a modern mobile interface.

Data Filtering:
Only the four key data points (name, cuisines, rating, and address) are extracted and shown.

Display Limit:
Only the first 10 restaurants are displayed.

User Interaction:
Users enter a postcode, and the app fetches and displays the restaurant data. The interface is designed to be clean and modern.

🎯 Assignment Criteria
Display all four restaurant data points in your interface.

Focus on clean presentation rather than a huge list of data.

Include instructions on how to build, compile, and run your solution.

Document any assumptions or clarifications in the README.

Mention any improvements or future enhancements.

Programming Language: Swift (using SwiftUI).

🔧 How to Build, Compile, and Run
Prerequisites:

Xcode 13 or later

macOS Catalina or later

Clone the Repository:

bash
Copy
git clone https://github.com/yourusername/your-repo-name.git
Open the Project:

bash
Copy
open JustEat2025.xcodeproj
Run the Application:

Select an iOS Simulator or a connected device.

Press Cmd + R to build and run the application.

On launch, enter a postcode (e.g., M2 3AW) to fetch and display restaurant data.


🤔 Assumptions
The API returns data in the expected format.

Only the first 10 restaurants are shown.

The application is built using Swift and SwiftUI.

All required restaurant fields (name, cuisines, rating, address) exist in the API response.

Custom colors and assets are defined in the asset catalog.

💡 Improvements and Future Enhancements
Enhanced Error Handling:
Improve error messaging and handling for network or JSON parsing failures.

Dynamic Search:
Implement live search filtering of restaurant data as the user types.

UI/UX Enhancements:
Further refine the UI with animations and adaptive layouts.

Data Caching:
Cache API responses to reduce network calls and improve performance.

Testing:
Add unit tests and UI tests for more robust functionality.

Accessibility:
Enhance accessibility support for a wider range of users.

📝 Conclusion
This project demonstrates the use of Swift and SwiftUI to build a modern application that fetches and displays restaurant data from an API. The focus is on presenting key information clearly while maintaining a sleek, modern design. Feedback and suggestions for future improvements are welcome!
