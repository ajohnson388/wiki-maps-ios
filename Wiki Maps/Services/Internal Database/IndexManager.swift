//
//  IndexManager.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/18/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct IndexManager {
    
    /**
     Domain name view drives the game selection that would appear
     in the menu or in the onboarding screen.
     */
    static func setupDomainNameView(inDatabase db: CBLDatabase, version: Int) {
        let collection = Collection.domain
        let viewName = View.name.getName(forCollection: collection)
        let view = db.viewNamed(viewName)
        view.documentType = collection.name
        view.setMapBlock({ doc, emit in
            // Get the name
            guard let name = doc[Domain.Keys.title] as? String else {
                return
            }
            emit(name, nil)
        }, version: "\(version)")
    }
    
    /**
     Used a to create an index for each set of map items via longitude
     and latitudes.
     */
    static func setupMapItemsGeoView(inDatabase db: CBLDatabase,
                                     forCollection collection: Collection,
                                     version: Int) {
        let viewName = View.geo.getName(forCollection: collection)
        let view = db.viewNamed(viewName)
        view.documentType = collection.name
        view.setMapBlock({ doc, emit in
            // Find the long/lat, if any
            guard
                let keyPath = collection.geoKeyPath,
                let location = doc.valueForKeyPath(keyPath: keyPath) as? [String: Any],
                let latitude = location[Location.Keys.latitude] as? Double,
                let longitude = location[Location.Keys.longitude] as? Double else {
                    return
            }
            
            // Create the geo key and emit the doc
            let key = CBLGeoPoint(x: longitude, y: latitude)
            emit(key, nil)
        }, version: "\(version)")
    }
    
    /**
     Provides a view that drives the global map items list view.
     The list view is sperated into categories and subcategories.
     */
    static func setupMapItemsCategoryView(inDatabase db: CBLDatabase,
                                          forCollection collection: Collection,
                                          version: Int) {
        // Keys -->  [category, subcategory, name]
        let viewName = View.category.getName(forCollection: collection)
        let view = db.viewNamed(viewName)
        view.documentType = collection.name
        view.setMapBlock({ doc, emit in
            let category = doc[MapItem.Keys.category] as? String
            let subcategory = doc[MapItem.Keys.subcategory] as? String
            let name = doc[MapItem.Keys.title] as? String
            let keys = [category, subcategory, name]
            emit(keys, nil)
        }, version: "\(version)")
    }
    
    
    /**
     Each game (data set) will have its own search view. This view
     permits searching of an relvant data field in a map item.
     */
    static func setupMapItemsSearchView(inDatebase db: CBLDatabase,
                                        forCollection collection: Collection,
                                        version: Int) {
        let viewName = View.search.getName(forCollection: collection)
        let view = db.viewNamed(viewName)
        view.documentType = collection.name
        view.setMapBlock({ doc, emit in
            // Get the searchable keys from the map item
            let title = doc[MapItem.Keys.title] as? String
            let subtitle = doc[MapItem.Keys.subtitle] as? String
            let category = doc[MapItem.Keys.category] as? String
            let subcategory = doc[MapItem.Keys.subcategory] as? String
            let tag = (doc[MapItem.Keys.tags] as? [String])?
                .map { $0.lowercased() }
                .joined(separator: " ")
                .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let searchables = [title, subtitle, category, subcategory, tag].flatMap({$0})
            let searchText = searchables.filter { $0 != "" }.joined(separator: " ")
            
            // Emit the key
            let key = CBLTextKey(searchText)
            emit(key, nil)
        }, version: "\(version)")
    }
    
    /**
     Each resource view contains all of the resource blobs
     used per game. For now just a collection
     */
    static func setupResourceView(inDatabase db: CBLDatabase,
                                  version: Int) {
        let collection = Collection.resources
        let viewName = View.category.getName(forCollection: collection)
        let view = db.viewNamed(viewName)
        view.documentType = collection.name
        view.setMapBlock({ doc, emit in
            guard
                let domainName = doc[Resource.Keys.domainName] as? String,
                let subtype = doc[Resource.Keys.subtype] as? String else {
                    return
            }
            let key = [domainName, subtype]
            emit(key, nil)
        }, version: "\(version)")
    }
    
    /**
     Only one user profile view will exist that captures every profile
     for every game.
     */
    static func setupUserProfileView(inDatabase db: CBLDatabase, version: Int) {
        let collection = Collection.userData
        let viewName = View.category.getName(forCollection: collection)
        let view = db.viewNamed(viewName)
        view.documentType = collection.name
        view.setMapBlock({ doc, emit in
            guard
                let domainName = doc[UserProfile.Keys.domainName] as? String,
                let name = doc[UserProfile.Keys.name] as? String else {
                    return
            }
            let key = [domainName, name]
            emit(key, nil)
        }, version: "\(version)")
    }
}
