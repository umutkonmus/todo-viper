//
//  CoreDataManagerTests.swift
//  todo-viper
//
//  Created by Umut Konmuş on 22.03.2025.
//


import XCTest
import CoreData
@testable import todo_viper

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    var mockPersistentContainer: NSPersistentContainer!
    
    override func setUp() {
        super.setUp()
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        mockPersistentContainer = NSPersistentContainer(name: "todo_viper")
        mockPersistentContainer.persistentStoreDescriptions = [description]
        
        mockPersistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
        
        coreDataManager = CoreDataManager.shared
        coreDataManager.persistentContainer = mockPersistentContainer 
    }
    
    override func tearDown() {
        coreDataManager = nil
        mockPersistentContainer = nil
        super.tearDown()
    }
    
    func testAddTodo() {
        coreDataManager.addTodo(title: "Test Todo")
        
        do {
            let todos = try coreDataManager.fetchTodos()
            XCTAssertEqual(todos.count, 1)
            XCTAssertEqual(todos.first?.title, "Test Todo")
            XCTAssertFalse(todos.first!.isCompleted)
        } catch {
            XCTFail("Fetch todos failed with error: \(error)")
        }
    }
    
    func testFetchTodos() {
        coreDataManager.addTodo(title: "Todo 1")
        coreDataManager.addTodo(title: "Todo 2")
        
        do {
            let todos = try coreDataManager.fetchTodos()
            XCTAssertEqual(todos.count, 2)
        } catch {
            XCTFail("Fetching todos failed: \(error)")
        }
    }
    
    func testDeleteTodo() {
        coreDataManager.addTodo(title: "Todo to be deleted")
        
        do {
            let todos = try coreDataManager.fetchTodos()
            XCTAssertEqual(todos.count, 1)
            
            coreDataManager.deleteTodo(todo: todos.first!)
            
            let updatedTodos = try coreDataManager.fetchTodos()
            XCTAssertEqual(updatedTodos.count, 0)
        } catch {
            XCTFail("Error during deletion test: \(error)")
        }
    }
    
    func testEditTodo() {
        coreDataManager.addTodo(title: "Initial Title")
        
        do {
            var todos = try coreDataManager.fetchTodos()
            XCTAssertEqual(todos.first?.title, "Initial Title")
            
            coreDataManager.editTodo(todo: todos.first!, newTitle: "Updated Title", isCompleted: true)
            
            todos = try coreDataManager.fetchTodos()
            XCTAssertEqual(todos.first?.title, "Updated Title")
            XCTAssertTrue(todos.first!.isCompleted)
        } catch {
            XCTFail("Error during edit test: \(error)")
        }
    }
}
