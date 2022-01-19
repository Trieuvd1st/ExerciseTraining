import Foundation
import RealmSwift
import Accessibility

class FoodInfo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var rating: Int = 0
    
    convenience init(image: String, name: String, rating: Int) {
        self.init()
        self.image = image
        self.name = name
        self.rating = rating
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class FoodDao {
    
    let realm = try! Realm()
    
    func addFood(item: FoodInfo) {
        let maxId = realm.objects(FoodInfo.self).max(ofProperty: "id") as Int? ?? 0
        item.id = maxId + 1
        try! realm.write {
            realm.add(item)
        }
    }
    
    func getAllFood() -> [FoodInfo] {
        return realm.objects(FoodInfo.self).toArray(ofType: FoodInfo.self)
    }
    
    func deleteAllData() {
        if !realm.isEmpty {
            try! realm.write {
                realm.deleteAll()
            }
        }
    }
    
    func isListEmpty() -> Bool {
        return realm.isEmpty
    }
    
    func deleteFoodById(id: Int) {
        let itemFilter = realm.objects(FoodInfo.self).filter("id = %@", id).first
        if let itemFilter = itemFilter {
            try! realm.write {
                realm.delete(itemFilter)
            }
        }
    }
    
    func updateFoodById(id: Int, item: FoodInfo) {
        let itemFilter = realm.objects(FoodInfo.self).filter("id = %@", id).first
        if let itemFilter = itemFilter {
            try! realm.write {
                itemFilter.name = item.name
                itemFilter.image = item.image
                itemFilter.rating = item.rating
            }
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
