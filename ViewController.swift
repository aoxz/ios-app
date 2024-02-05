import UIKit
import SQLite // Import SQLite library

class ViewController: UIViewController {
    
    var database: Connection! // SQLite database connection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            // Get the path to the SQLite database file
            let dbPath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("database.db").path
            
            // Initialize the SQLite database connection
            database = try Connection(dbPath)
            
            // Define table and columns
            let users = Table("users")
            let id = Expression<Int>("id")
            let name = Expression<String>("name")
            let age = Expression<Int>("age")
            
            // Create the 'users' table if it doesn't exist
            try database.run(users.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(age)
            })
            
            // Insert sample data into the 'users' table
            let insert = users.insert(name <- "John", age <- 30)
            try database.run(insert)
            
            // Fetch data from the 'users' table
            for user in try database.prepare(users) {
                print("User id: \(user[id]), Name: \(user[name]), Age: \(user[age])")
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
}
