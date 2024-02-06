# toadDB - iOS App

toadDB is a lightweight and versatile database management system designed for simplicity and ease of use. It provides developers with the tools they need to efficiently store, retrieve, and manipulate data in their applications.

## Features

- **SQLite Backend**: Built on top of the SQLite database engine, toadDB offers reliable and efficient data storage and retrieval capabilities.
- **Simple API**: toadDB provides a straightforward API for performing common database operations such as creating tables, inserting data, querying data, and more.
- **Error Handling**: Robust error handling ensures that potential errors related to database operations are properly caught and reported, making it easier to debug and troubleshoot issues.
- **Customizable**: Developers can easily extend and customize toadDB to suit their specific application requirements, thanks to its modular and flexible design.

## Getting Started

### Installation

To integrate toadDB into your project, simply add the `toadDB.framework` file to your Xcode project and import it into your code.

### Usage

```swift
import toadDB

// Initialize the database
let dbManager = DatabaseManager(dbName: "my_database.db")

// Create a table
dbManager.createTable(tableName: "users", columns: ["id INTEGER PRIMARY KEY", "name TEXT", "age INTEGER"])

// Insert data
dbManager.insertData(tableName: "users", data: (1, "John", 30))

// Fetch data
let userData = dbManager.fetchData(tableName: "users")
print(userData)

// Close the connection
dbManager.closeConnection()
