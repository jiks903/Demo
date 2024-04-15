//
//  OpenweathermapViewModel.swift
//  Demo
//
//  Created by Jeegnesh Solanki on 15/04/24.
//

import Foundation

protocol HomeDataServices: AnyObject {
    func reloadData() // Data Binding - PROTOCOL (View and ViewModel Communication)
}

class HomeViewModel {

    var ListData: [AcharyaprashantmapModel] = [] {
        didSet {
            self.HomeDataDelegate?.reloadData()
        }
    }
    private let manager = APIManager()
    weak var HomeDataDelegate: HomeDataServices?

    // @MainActor -> DispatchQueue.Main.async
    @MainActor func fetchWeatherData() {
        Task { // @MainActor in
            do {
                let acharyaprashantmapModel: [AcharyaprashantmapModel] = try await manager.request(url: MediacoveragesURL)
                self.ListData = acharyaprashantmapModel
            }catch {
                print(error)
            }
        }

    }

  
}
