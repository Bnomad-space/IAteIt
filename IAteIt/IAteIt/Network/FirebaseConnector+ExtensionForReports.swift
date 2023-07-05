//
//  FirebaseConnector+ExtensionForReports.swift
//  IAteIt
//
//  Created by Beone on 2023/07/05.
//

import Firebase
import FirebaseFirestore
import SwiftUI

extension FirebaseConnector {
    static let reports = Firestore.firestore().collection("reports")
    
    func sendReport(reporterId: String, reportedTime: Date, mealId: String, reason: String) {
        let report = Report(
            id: UUID().uuidString,
            reporterId: reporterId,
            reportedTime: reportedTime,
            mealId: mealId,
            reason: reason
        )
        
        do {
            let documentData = try Firestore.Encoder().encode(report)
            FirebaseConnector.reports.document(report.id).setData(documentData) { error in
                if let error = error {
                    print("Failed to send report: \(error.localizedDescription)")
                } else {
                    print("Report sent successfully!")
                }
            }
        } catch {
            print("Error encoding report: \(error.localizedDescription)")
        }
    }
    
}
