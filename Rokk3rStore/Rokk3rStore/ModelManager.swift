//
//  ModelManager.swift
//  Rokk3rStore
//
//  Created by Esteban Garcia Henao on 6/24/16.
//  Copyright © 2016 Esteban Garcia Henao. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ModelManager {
    
    static let BRANDS = ["Gap", "Banana Republic", "Boss", "Hugo Boss", "Taylor", "Rebecca Taylor"]
    static let CLOTHINGTYPES = ["Denim", "Pants", "Sweaters", "Skirts", "Dresses"]
    
    class func firstTime() {
        
        let isNotFirstTime = NSUserDefaults.standardUserDefaults().boolForKey("isNotFirstTime")
        
        if (isNotFirstTime == false) {
            
            preloadBrandsClothingTypes()
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isNotFirstTime")
        }
    }
    
    class func preloadBrandsClothingTypes() {
        
        let realm = try! Realm()
        realm.beginWrite()
        
        for brandName in BRANDS {
            
            let brand = Brand()
            brand.name = brandName
            
            realm.add(brand)
        }
        
        for clothingTypeName in CLOTHINGTYPES {
            
            let clothingType = ClothingType()
            clothingType.name = clothingTypeName
            
            realm.add(clothingType)
        }
        
        try! realm.commitWrite()
    }
    
    class func getBrands() -> Results<Brand> {
        
        let realm = try! Realm()
        
        return realm.objects(Brand)
    }
    
    class func getClothingTypes() -> Results<ClothingType> {
        
        let realm = try! Realm()
        
        return realm.objects(ClothingType)
    }
    
    class func search(queriesArray: Array<String>) -> Dictionary<String, Array<String>> {
        
        var brandsFound = Array<String>()
        var clothingTypesFound = Array<String>()
        var resultQuery = Array<String>()
        
        for query in queriesArray {
            
            let (type, result) = find(query)
            
            switch(type) {
                
            case .Brand:
                brandsFound.appendContentsOf(result)
                continue
                
            case .ClothingType:
                clothingTypesFound.appendContentsOf(result)
                break
                
            case .None:
                resultQuery.appendContentsOf(result)
            }
        }
        
        var resultsByType = Dictionary<String, Array<String>>()
        
        resultsByType["Brand"] = brandsFound
        resultsByType["Clothing Type"] = clothingTypesFound
        resultsByType["Result Query"] = resultQuery
        
        return resultsByType
    }
    
    class func find(query: String) -> (Types, Array<String>) {
        
        let brands = getBrands()
        let clothingTypes = getClothingTypes()
        
        let queryString = "name contains '\(query)'"
        
        let bs = brands.filter(queryString)
        let cs = clothingTypes.filter(queryString)
        
        if bs.count > 0 {
            
            var brandArray = Array<String>()
            
            for b in bs {
                
                brandArray.append(b.name)
            }
            
            return (.Brand, brandArray)
        }
        else if cs.count > 0 {
            
            var clothingTypeArray = Array<String>()
            
            for c in cs {
                
                clothingTypeArray.append(c.name)
            }
            
            return (.ClothingType, clothingTypeArray)
        }
        else {
            
            return (.None, [query])
        }
    }
}