//: A UIKit based Playground for presenting user interface
  
import UIKit
import SwiftUI

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
}

class NetworkingManager {
    var storedCompletionBlock: ((Result<Data, NetworkingError>) -> Void)?
    
    func requestDataFromServer(from url: String, completion: @escaping ((Result<Data, NetworkingError>) -> Void)) {
        self.storedCompletionBlock = completion
        
        //even if view model is set to nil, networkmanager will not be deallocated from memory, because it has strong reference in this delay closure
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //here, weak reference will not execute callback
            self.storedCompletionBlock?(.success(Data()))
            self.storedCompletionBlock = nil // if this is not done, it will lead to memory leak/ retain count
        }
    }
    deinit {
        print("NetworkingManager deinit")
    }
}

class ViewModel {
    var networkingManager: NetworkingManager? = NetworkingManager()
    var receivedData: Data?
    
    func requestDatafromAPI() {
        networkingManager?.requestDataFromServer(from: "MyAPIURL/EndPoint", completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.receivedData = data //retain cycle might be created if self is not declared as weak // count += 1
                                          //if self is declared as weak, counter will not increase
            case .failure(let error):
                print("Error: \(error)")
                break
            }
        })
    }
    deinit {
        print("ViewModel deinit")
    }
    
}

//by default it is a strong reference
var viewModel: ViewModel? = ViewModel()
viewModel?.requestDatafromAPI()
viewModel = nil


