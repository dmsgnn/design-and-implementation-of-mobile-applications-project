//
//  DashboardViewModel.swift
//  karma
//
//  Created by Giovanni Demasi on 26/12/22.
//
import Combine

final class DashboardViewModel: ObservableObject {
    @Published var campaignRepository = CollectionRepository()
    @Published var campaigns: [Collection] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        campaignRepository.$campaigns.assign(to: \.campaigns, on: self)
            .store(in: &cancellables)
    }
    
    func updateHome() {
        campaigns.removeAll()
        campaignRepository.get()
    }
    
}
