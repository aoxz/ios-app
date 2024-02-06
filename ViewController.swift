import UIKit
import SQLite // Import SQLite library

class ViewController: UIViewController {
    
    var database: Connection! // SQLite database connection
    
    // Constants for table name and column names
    enum TableNames: String {
        case users
    }
    
    enum ColumnNames: String {
        case id, name, age
    }
    
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
        let users = Table(TableNames.users.rawValue)
        
        try database.run(users.create(ifNotExists: true) { table in
            table.column(ColumnNames.id.rawValue, primaryKey: true)
            table.column(ColumnNames.name.rawValue)
            table.column(ColumnNames.age.rawValue)
        })
    }
    
    // Function to insert sample data into the 'users' table
    func insertSampleData() throws {
        let users = Table(TableNames.users.rawValue)
        
        let insert = users.insert(ColumnNames.name.rawValue <- "John", ColumnNames.age.rawValue <- 30)
        try database.run(insert)
    }
    
    // Function to fetch and print data from the 'users' table
    func fetchAndPrintUserData() throws {
        let users = Table(TableNames.users.rawValue)
        
        for user in try database.prepare(users) {
            print("User id: \(user[ColumnNames.id.rawValue]), Name: \(user[ColumnNames.name.rawValue]), Age: \(user[ColumnNames.age.rawValue])")
        }
    }
}
