//
//  HealthQuoteViewController.swift
//  happykids
//
//  Created by Simone Karani on 2/21/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import DropDown

class HealthQuoteViewController: UIViewController {
    
    @IBOutlet weak var healthquote: UITextView!
    
    let mQuoteData: HealthQuotesData = HealthQuotesData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mQuote = mQuoteData.getMoralQuote()
        healthquote.text = "\"" + mQuote.quote! + "\"" + "\n\n\n" + "- " + mQuote.author!
        saveRecord(qMsg: mQuote.quote!, qAuthor: mQuote.author!)
        updateQuoteStoredList()
    }
    
    override func viewDidLayoutSubviews() {
        healthquote.centerVertically()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        healthquote.centerVertically()
    }
    
    func saveRecord(qMsg: String, qAuthor: String) {
        if #available(iOS 10.0, *) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let quoteRecItem = HealthRecItem(context: context)
            quoteRecItem.quoteDate = Date().string(format: "MM/dd/yyyy")
            quoteRecItem.quoteMsg = qMsg
            quoteRecItem.quoteAuthor = qAuthor
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            let quoteRecItem = HealthRecItem()
            quoteRecItem.quoteDate = Date().string(format: "MM/dd/yyyy")
            quoteRecItem.quoteMsg = qMsg
            quoteRecItem.quoteAuthor = qAuthor
        }
        saveContext()
    }
    
    func updateQuoteStoredList() {
        let request: NSFetchRequest<HealthRecItem> = HealthRecItem.fetchRequest()

        if #available(iOS 10.0, *) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do {
                let quoteItemArray = try context.fetch(request)
                if (quoteItemArray.count > 8) {
                    context.delete(quoteItemArray[0])
                    saveContext()
                }
            } catch {
                print("Error in loading \(error)")
            }
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            do {
                let quoteItemArray = try context.fetch(request)
                if (quoteItemArray.count > 8) {
                    context.delete(quoteItemArray[0])
                    saveContext()
                }
            } catch {
                print("Error in loading \(error)")
            }
        }
    }
    
    func saveContext() {
        if #available(iOS 10.0, *) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    }
}
