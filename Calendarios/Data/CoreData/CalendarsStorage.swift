//
//  CalendarsStorage.swift
//  Calendarios
//
//  Created by David on 11/8/21.
//

import CoreData
import Foundation
import Combine
import SwiftUI

class CalendarStorage:NSObject, ObservableObject {
    var calendars = CurrentValueSubject<[CalendarModel], Never>([])
    private let fetchController: NSFetchedResultsController<CalendarModel>
    private let context = PersistenceController.shared.container.viewContext
    static let shared: CalendarStorage = CalendarStorage()
    
    private override init() {
        let fetchRequest: NSFetchRequest<CalendarModel> = CalendarModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CalendarModel.objectID, ascending: true)]
        
        fetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        super.init()
        fetchController.delegate = self

        do {
            try fetchController.performFetch()
            calendars.value = fetchController.fetchedObjects ?? []
        } catch {
            NSLog("Error: Could not fetch object")
        }
    }
    
    func add(name: String, imageColor: String, icon: String) {
        let newCalendar = CalendarModel(context: context)
        newCalendar.name = name
        newCalendar.iconColor = imageColor
        newCalendar.icon = icon
        PersistenceController.shared.save()
        
    }
    
    func update(id: Int) {
        
    }
    
    func delete(id: Int) {
        let itemToDelete = calendars.value[id]
        PersistenceController.shared.delete(itemToDelete)
    }
    
}

extension CalendarStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let calendars = controller.fetchedObjects as? [CalendarModel] else { return }
        self.calendars.value = calendars
    }
}
