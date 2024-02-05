import UIKit
import SQLite // Import SQLite library

class ViewController: UIViewController {
    
    var database: Connection! // SQLite database connection
    
    // Constants for table name and column names
    let tableName = "users"
    let columnID = Expression<Int>("id")
    let columnName = Expression<String>("name")
    let columnAge = Expression<Int>("age")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            // Get the path to the SQLite database file
            let dbPath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("database.db").path
            
            // Initialize the SQLite database connection
            database = try Connection(dbPath)
            
            // Create the 'users' table if it doesn't exist
            try createTableIfNotExists()
            
            // Insert sample data into the 'users' table
            try insertSampleData()
            
            // Fetch data from the 'users' table
            try fetchAndPrintUserData()
            
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        } catch {
            print("An unknown error occurred.")
        }
    }
    
    // Function to create the 'users' table if it doesn't exist
    func createTableIfNotExists() throws {
        let users = Table(tableName)
        
        try database.run(users.create(ifNotExists: true) { table in
            table.column(columnID, primaryKey: true)
            table.column(columnName)
            table.column(columnAge)
        })
    }
    
    // Function to insert sample data into the 'users' table
    func insertSampleData() throws {
        let users = Table(tableName)
        
        let insert = users.insert(columnName <- "John", columnAge <- 30)
        try database.run(insert)
    }
    
    // Function to fetch and print data from the 'users' table
    func fetchAndPrintUserData() throws {
        let users = Table(tableName)
        
        for user in try database.prepare(users) {
            print("User id: \(user[columnID]), Name: \(user[columnName]), Age: \(user[columnAge])")
        }
    }
}
