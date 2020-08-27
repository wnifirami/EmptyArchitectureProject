//
//  RealmManager.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/23/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    // MARK: - Create
    
    func create<T: Object>(object: T) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try self.realm.safeWrite {
                    self.realm.add(object)
                    observer.onNext(true)
                }
            } catch {
                
                observer.onNext(false)
            }
            return Disposables.create()
        }
    }
    
    func createArray<T: Object>(object: [T]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try self.realm.safeWrite {
                    self.realm.add(object)
                    observer.onNext(true)
                }
            } catch {
                
                observer.onNext(false)
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Read
    
    func readArray<T: Object>(object: T.Type)   -> Observable<[T]> {
        return Observable<[T]>.create { observer -> Disposable in
            let realm = RealmService.shared.realm
            let results = realm.objects(T.self)
            if results != nil {
                observer.onNext(results.map({$0}))
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Read
    
    func checkData<T: Object>(object: T.Type)   -> Observable<Int> {
        return Observable<Int>.create { observer -> Disposable in
            let realm = RealmService.shared.realm
            let results = realm.objects(T.self)
            if results != nil {
                observer.onNext(results.count)
            }
            return Disposables.create()
        }
    }
    
    func deleteAll<T: Object>(_ data: T.Type)   -> Observable<Bool>{
         return Observable<Bool>.create { observer -> Disposable in
        
            self.realm.refresh()
  do {
    try? self.realm.safeWrite {
        self.realm.delete(self.realm.objects(T.self))
        debugPrint("objectDeleted")
             observer.onNext(true)
    } }
  catch {
                 observer.onNext(false)
            }
                return Disposables.create()
            }
        
        

    }
    // delete particular object
       func deleteObject(objs : Object) {
          try? realm.write ({
               realm.delete(objs)
            debugPrint("deleted")
       })
       }
    // MARK: - get object By id
    func readObjectById<T: Object>(object: T.Type, id: Int)   -> Observable<T> {
        return Observable<T>.create { observer -> Disposable in
            let realm = RealmService.shared.realm
            let result = realm.object(ofType: T.self, forPrimaryKey: id)
            if let result = result  {
                observer.onNext(result)
            }
            
            return Disposables.create()
        }
        
    }
    
    // MARK: - Update
    
    func update<T: Object>(object: T, with dictionary: [String: Any?]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try self.realm.write {
                    for (key, value) in dictionary {
                        object.setValue(value, forKey: key)
                    }
                    observer.onNext(true)
                }
            } catch {
                observer.onNext(false)
            }
            return Disposables.create()
        }
        
    }
    
    
    
    // MARK: - Append an object to a 'List' (which is actually an Array, but realm doesn't currently support Arrays)
    
    func appendToList<T: Object>(list: List<T>?, with items: [T]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let realm = try! Realm()
            do {
                try! realm.write {
                    list?.append(objectsIn: items)
                    observer.onNext(true) } }
            catch {
                observer.onNext(false)
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Delete
    
    func delete<T: Object>(_ object: T) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try self.realm.write {
                    self.realm.delete(object)
                    observer.onNext(true) } }
            catch {  observer.onNext(false)  }
            return Disposables.create()
        }
        
    }
    
    // MARK: - Clear DataBase
    func  clearDataBase() -> Observable<Bool>{
        return Observable<Bool>.create { observer in
            do {
                try! self.realm.write {
                    self.realm.deleteAll()
                    observer.onNext(true) }  }
            catch {
                observer.onNext(false) }
            return Disposables.create()
        }
    }
    
}

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
