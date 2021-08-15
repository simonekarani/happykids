//
//  MoralQuoteScreenController.swift
//  happykids
//
//  Created by Simone Karani on 2/21/21.
//  Copyright © 2021 Simone Karani. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import DropDown

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteDetail: UITextView!
    
    let mQuoteData: MoralQuotesData = MoralQuotesData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Past",
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
        
        let mQuote = mQuoteData.getMoralQuote()
        quoteDetail.text = "\"" + mQuote.quote! + "\"" + "\n\n\n" + "- " + mQuote.author!
        saveRecord(qMsg: mQuote.quote!, qAuthor: mQuote.author!)
        updateQuoteStoredList()
    }
    
    override func viewDidLayoutSubviews() {
        quoteDetail.centerVertically()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        quoteDetail.centerVertically()
    }
    
    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "gotoPastQuotes", sender: self)
    }
    
    func saveRecord(qMsg: String, qAuthor: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let quoteRecItem = QuoteRecItem(context: context)
        quoteRecItem.quoteDate = Date().string(format: "MM/dd/yyyy")
        quoteRecItem.quoteMsg = qMsg
        quoteRecItem.quoteAuthor = qAuthor
        saveContext()
    }
    
    func updateQuoteStoredList() {
        let request: NSFetchRequest<QuoteRecItem> = QuoteRecItem.fetchRequest()

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
    }
    
    func saveContext() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
