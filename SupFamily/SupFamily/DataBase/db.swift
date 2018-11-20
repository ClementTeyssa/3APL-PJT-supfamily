//
//  db.swift
//  SupFamily
//
//  Created by Supinfo on 15/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//


//let db = openDatabase()
//initDbTables(db : db!)
//insertRequest(db : db!, insertStatementString : "INSERT INTO User VALUES (1,\"AXEL\",\"KIM\")")
//updateRequest(db : db!, updateStatementString: "UPDATE User SET password = \"AXKI\" WHERE userId = 1")
//deleteRequest(db: db!, deleteStatementString: "DELETE FROM User WHERE userId = 1")
//closeDatabase(db: db!)

import Foundation
import SQLite3

class DataBaseSupFamily{
    static let db = {
        openDatabase()
    }()
    
}

func openDatabase() -> OpaquePointer? {
    var db: OpaquePointer? = nil
    let fileURL: URL = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("dbSupFamily.sqlite")
    if sqlite3_open(fileURL.path, &db) == SQLITE_OK{
        print("Successfully opened connection to database")
    } else {
        print("Cannot connect to database")
    }
    return db
}

func initDbTables(db : OpaquePointer) {
    let createTableUser : String = """
                              CREATE TABLE IF NOT EXISTS User(
                              userId SMALLINT UNSIGNED NOT NULL,
                              username VARCHAR2(255) NOT NULL,
                              password VARCHAR2(255) NOT NULL,
                              PRIMARY KEY(userId))
                              """
    let createTableFamily : String = """
                                CREATE TABLE IF NOT EXISTS Family(
                                familyId SMALLINT UNSIGNED NOT NULL,
                                name VARCHAR2(255) NOT NULL,
                                PRIMARY KEY(familyId))
                                """
    let createTableMember : String  = """
                                CREATE TABLE IF NOT EXISTS Member(
                                userId SMALLINT UNSIGNED NOT NULL,
                                lasName VARCHAR2(255) NOT NULL,
                                firstName VARCHAR2(255) NOT NULL,
                                latitude FLOAT,
                                longitude FLOAT,
                                familyId SMALLINT UNSIGNED NOT NULL,
                                PRIMARY KEY (userId),
                                FOREIGN KEY (userId) REFERENCES User(userId),
                                FOREIGN KEY (familyId) REFERENCES Family(familyId))
                                """
    createTable(db : db, createTableString: createTableUser)
    createTable(db : db, createTableString: createTableFamily)
    createTable(db : db, createTableString: createTableMember)
}

func createTable(db : OpaquePointer, createTableString : String) {
    var createTableStatement: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            print("Table created.")
        } else {
            print("Table could not be created.")
        }
    } else {
        print("CREATE TABLE statement could not be prepared.")
    }
    sqlite3_finalize(createTableStatement)
}

func insertUser(db : OpaquePointer, userId: Int, username: String, password: String) {
    let insertString = "INSERT INTO User VALUES (\(userId),\"\(username)\",\"\(password)\")"
    print(insertString)
    insertRequest(db: db, insertStatementString: insertString)
}

func insertFamily(db : OpaquePointer, family : Family) {
    let insertString = "INSERT INTO Family VALUES (\"\(family.id)\", \"\(family.name)\")"
    insertRequest(db: db, insertStatementString: insertString)
    for user in family.members! {
        print(user.firstName)
        insertMember(db: DataBaseSupFamily.db!, member: user, familyId: family.id)
    }
}

func insertMember(db : OpaquePointer, member : User, familyId: Int) {
    let latitude: String = {
        if let latitude = member.latitude {
            return String(latitude)
        }
        return "null"
    }()
    
    let longitude: String = {
        if let longitude = member.longitude {
            return String(longitude)
        }
        return "null"
    }()
    
    let insertString = "INSERT INTO Member VALUES (\"\(member.userId)\", \"\(member.lasName)\",\"\(member.firstName)\",\"\(latitude)\",\"\(longitude)\", \(familyId))"
    
    insertRequest(db: db, insertStatementString: insertString)
}



/*func updateUser(db : OpaquePointer, user : User) {
    let updateString = "UPDATE User SET username = \(user.username) AND password = \(user.password) WHERE userId = \(user.userId)"
    updateRequest(db: db, updateStatementString: updateString)
}

func updateFamily(db : OpaquePointer, family : Family) {
    let updateString = "UPDATE Family SET name = \(family.name) WHERE familyId = \(family.id)"
    updateRequest(db: db, updateStatementString: updateString)
}

func updateMember(db : OpaquePointer, member : User) {
    let updateString = "UPDATE Member SET lasName = \(member.lasName) AND firstName = \(member.firstName) AND latitude = \(member.latitude) AND longitude = \(member.longitude) AND familyId = \(member.familyId) WHERE userId = \(member.userId)"
    updateRequest(db: db, updateStatementString: updateString)
}*/

/*func deleteUser(db : OpaquePointer, user : User) {
    let deleteString = "DELETE FROM User WHERE userId = \(user.userId)"
    deleteRequest(db: db, deleteStatementString: deleteString)
}*/

/*func deleteFamily(db : OpaquePointer, family : Family) {
    let deleteString = "DELETE FROM Family WHERE familyId = \(family.id)"
    deleteRequest(db: db, deleteStatementString: deleteString)
}

func deleteMember(db : OpaquePointer, member : User) {
    let deleteString = "DELETE FROM Member WHERE userId = \(member.userId)"
    deleteRequest(db: db, deleteStatementString: deleteString)
}

func selectUser(db : OpaquePointer, id : Int) -> User {
    var userId : Int?
    var username : String?
    var password : String?
    var lasName : String?
    var firstName : String?
    var latitude : Double?
    var longitude : Double?
    var familyId : Int?
    var queryStatement: OpaquePointer? = nil
    let queryStatementString = "SELECT * FROM User WHERE userId = \(id)"
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        if sqlite3_step(queryStatement) == SQLITE_ROW {
            userId = Int(sqlite3_column_int(queryStatement, 0))
            username = String(cString : sqlite3_column_text(queryStatement, 1))
            password = String(cString : sqlite3_column_text(queryStatement, 2))
        } else {
            print("Query returned no results")
        }
    } else {
        print("SELECT statement could not be prepared")
    }
    sqlite3_finalize(queryStatement)
    var queryStatement2: OpaquePointer? = nil
    let queryStatementString2 = "SELECT * FROM Member WHERE userId = \(id)"
    if sqlite3_prepare_v2(db, queryStatementString2, -1, &queryStatement2, nil) == SQLITE_OK {
        if sqlite3_step(queryStatement2) == SQLITE_ROW {
            lasName = String(cString : sqlite3_column_text(queryStatement2, 1))
            firstName = String(cString : sqlite3_column_text(queryStatement2, 2))
            latitude = sqlite3_column_double(queryStatement2, 3)
            longitude = sqlite3_column_double(queryStatement2, 4)
            familyId = Int(sqlite3_column_int(queryStatement, 5))
        } else {
            print("Query returned no results")
        }
    } else {
        print("SELECT statement could not be prepared")
    }
    sqlite3_finalize(queryStatement2)
    return User(userId: userId!, username: username!, password: password!, lasName: lasName!, firstName: firstName!, latitude: latitude!, longitude: longitude!, familyId: familyId!)
}

func selectFamily(db : OpaquePointer, id : Int) -> Family {
    var familyId : Int?
    var familyName : String?
    var queryStatement: OpaquePointer? = nil
    let queryStatementString = "SELECT * FROM Family WHERE familyId = \(id)"
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        if sqlite3_step(queryStatement) == SQLITE_ROW {
            familyId = Int(sqlite3_column_int(queryStatement, 0))
            familyName = String(cString : sqlite3_column_text(queryStatement, 1))
        } else {
            print("Query returned no results")
        }
    } else {
        print("SELECT statement could not be prepared")
    }
    sqlite3_finalize(queryStatement)
    return Family(id: familyId!, name: familyName!, members: nil)
}*/


func insertRequest(db : OpaquePointer, insertStatementString : String) {
    var insertStatement: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
        if sqlite3_step(insertStatement) == SQLITE_DONE {
            print("Successfully inserted row.")
        } else {
            print("Could not insert row.")
        }
    } else {
        print("INSERT statement could not be prepared.")
    }
    sqlite3_finalize(insertStatement)
}
 
 /*func queryRequest(db : OpaquePointer, queryStatementString : String) {
    var queryStatement: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        if sqlite3_step(queryStatement) == SQLITE_ROW {
        } else {
            print("Query returned no results")
        }
    } else {
        print("SELECT statement could not be prepared")
    }
    sqlite3_finalize(queryStatement)
}

func updateRequest(db : OpaquePointer, updateStatementString : String) {
    var updateStatement: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
        if sqlite3_step(updateStatement) == SQLITE_DONE {
            print("Successfully updated row.")
        } else {
            print("Could not update row.")
        }
    } else {
        print("UPDATE statement could not be prepared")
    }
    sqlite3_finalize(updateStatement)
}

func deleteRequest(db : OpaquePointer, deleteStatementString : String) {
    var deleteStatement: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
        if sqlite3_step(deleteStatement) == SQLITE_DONE {
            print("Successfully deleted row.")
        } else {
            print("Could not delete row.")
        }
    } else {
        print("DELETE statement could not be prepared")
    }
    
    sqlite3_finalize(deleteStatement)
}

func closeDatabase(db : OpaquePointer) {
    sqlite3_close(db)
}*/
