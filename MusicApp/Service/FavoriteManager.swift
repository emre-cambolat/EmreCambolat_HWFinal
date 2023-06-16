//
//  FavoriteManager.swift
//  MusicApp
//
//  Created by Emre Cambolat on 15.06.2023.
//


import CoreData

protocol FavoriteManagerProtocol {
    func checkIfTrackIdExists(trackID: Int) -> Bool
    func addModel(_ model: MusicModel) -> Bool
    func deleteModel(with trackID: Int) -> Bool
    func deleteAllModels() -> Bool
    var getAllModels: [MusicModel] { get }
}

final class FavoriteManager: FavoriteManagerProtocol {
    
    static let shared = FavoriteManager()
    private let entityName: String = "FavoriteMusic"
    private let coreDataName: String = "MusicApp"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: coreDataName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        })
        return container
    }()
    
    private var models: [MusicModel] = []
    
    private init() {
        fetchData()
    }
    
    private func saveContext() -> Bool {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                return false
            }
        }
        return true
    }
    
    private func fetchData() {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        models.removeAll()
        
        do {
            let results = try context.fetch(fetchRequest)
            models = results.compactMap { managedObject in
                guard let trackID = managedObject.value(forKey: "trackID") as? Int,
                      let collectionID = managedObject.value(forKey: "collectionID") as? Int,
                      let trackName = managedObject.value(forKey: "trackName") as? String,
                      let artistName = managedObject.value(forKey: "artistName") as? String,
                      let collectionName = managedObject.value(forKey: "collectionName") as? String,
                      let previewURL = managedObject.value(forKey: "previewURL") as? String,
                      let artworkUrl100 = managedObject.value(forKey: "artworkUrl100") as? String,
                      let collectionPrice = managedObject.value(forKey: "collectionPrice") as? Double,
                      let trackPrice = managedObject.value(forKey: "trackPrice") as? Double,
                      let primaryGenreName = managedObject.value(forKey: "primaryGenreName") as? String,
                      let currency = managedObject.value(forKey: "currency") as? String else {
                    print("Invalid data format")
                    return nil
                }
                let newModel = MusicModel(
                    collectionID: collectionID,
                    trackID: trackID,
                    artistName: artistName,
                    collectionName: collectionName,
                    trackName: trackName,
                    previewURL: previewURL,
                    artworkUrl100: artworkUrl100,
                    collectionPrice: collectionPrice,
                    trackPrice: trackPrice,
                    primaryGenreName: primaryGenreName,
                    currency: currency)
                return newModel
            }
        } catch let error as NSError {
            print("Failed to fetch data: \(error), \(error.userInfo)")
        }
    }
    
    private func deleteManagedObject(_ managedObject: NSManagedObject) -> Bool {
        let context = persistentContainer.viewContext
        context.delete(managedObject)
        return saveContext()
    }
    
    func checkIfTrackIdExists(trackID: Int) -> Bool {
        return models.contains { $0.trackID == trackID }
    }
    
    var getAllModels: [MusicModel] { models }
    
    func addModel(_ model: MusicModel) -> Bool {
        guard !checkIfTrackIdExists(trackID: model.trackID ?? 0) else { return false }
        
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let modelObject = NSManagedObject(entity: entity, insertInto: context)
        
        modelObject.setValue(model.collectionID, forKey: "collectionID")
        modelObject.setValue(model.trackID, forKey: "trackID")
        modelObject.setValue(model.artistName, forKey: "artistName")
        modelObject.setValue(model.collectionName, forKey: "collectionName")
        modelObject.setValue(model.trackName, forKey: "trackName")
        modelObject.setValue(model.previewURL, forKey: "previewURL")
        modelObject.setValue(model.artworkUrl100, forKey: "artworkUrl100")
        modelObject.setValue(model.collectionPrice ?? 0, forKey: "collectionPrice")
        modelObject.setValue(model.trackPrice ?? 0, forKey: "trackPrice")
        modelObject.setValue(model.primaryGenreName, forKey: "primaryGenreName")
        modelObject.setValue(model.currency, forKey: "currency")
        
        let success = saveContext()
        if success {
            fetchData()
        }
        return success
    }
    
    func deleteModel(with trackID: Int) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "trackID == %d", trackID)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let managedObject = results.first {
                let success = deleteManagedObject(managedObject)
                if success {
                    fetchData()
                }
                return success
            }
        } catch let error as NSError {
            print("Failed to fetch data: \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    func deleteAllModels() -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            let success = saveContext()
            if success {
                fetchData()
            }
            return success
        } catch let error as NSError {
            print("Failed to delete all data: \(error), \(error.userInfo)")
        }
        
        return false
    }
}
