//
//  DashboardViewModel.swift
//  karma
//
//  Created by Giovanni Demasi on 26/12/22.
//
import Foundation

final class DashboardViewModel: ObservableObject {
    @Published var collections = [Collection]()
    private let service = CollectionService()
    
    init() {
        self.updateHome()
    }
    
    func updateHome() {
        collections.removeAll()
        service.fetchCollections() { collections in
            self.collections = collections
            for i in 0 ..< collections.count {
                self.collections[i] = collections[i]
            }
        }
    }
    
}
