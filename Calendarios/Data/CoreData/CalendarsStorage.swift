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
    
    var entityCalendar: NSEntityDescription?
    var entityMarkedDate: NSEntityDescription?

    private override init() {
        entityCalendar = NSEntityDescription.entity(forEntityName: "CalendarModel", in: self.context)
        entityMarkedDate = NSEntityDescription.entity(forEntityName: "MarkedDateModel", in: self.context)

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

    func markDate(date: Date, calendar: CalendarModel) {
//        let markedDate = MarkedDateModel(context: context)

        let markedDate = NSManagedObject(entity: entityMarkedDate!, insertInto: context)
        markedDate.setValue(date, forKey: "date")
        markedDate.setValue(1, forKey: "timesMarked")
        markedDate.setValue("NOTA", forKey: "note")
        let dateObject = calendar.mutableSetValue(forKey: "markedDates")
        dateObject.add(markedDate)
        //        calendar.markedDates = [markedDate]
        PersistenceController.shared.save()
    }
}

extension CalendarStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let calendars = controller.fetchedObjects as? [CalendarModel] else { return }
        self.calendars.value = calendars
    }
}

// 1. Subclass from `NSSecureUnarchiveFromDataTransformer`
@objc(PickedDateValueTransformer)
final class PickedDateTransformer: NSSecureUnarchiveFromDataTransformer {

    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: PickedDateTransformer.self))

    // 2. Make sure `UIColor` is in the allowed class list.
    override static var allowedTopLevelClasses: [AnyClass] {
        return [UIColor.self]
    }

    /// Registers the transformer.
    public static func register() {
        let transformer = PickedDateTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
