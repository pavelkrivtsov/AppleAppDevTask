//
//  NetworkService.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 11.05.2023.
//

import Foundation

enum NetworkResponse: String, Error {
    case authenticationError = "Ошибка авторизации"
    case failed = "Все упало"
    case responseFromTheServer = "Ответ от сервера"
    case badRequest = "Bad request"
    case noData = "No data"
    case unableToDecode = "Unable to decode"
}

protocol NetworkServiceOutput {
    func getAllCompanies(onCompletion: @escaping (Result<[ResponseItem], NetworkResponse>) -> Void)
}

final class NetworkService {
    
    enum NetworkResult<Error> {
        case success
        case failure(Error)
    }
 
    private func createRequest(from url: URL) -> URLRequest? {
        let parameters = ["offset": "0"]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else { return nil }
        var request = URLRequest(url: url)
        request.addValue("123", forHTTPHeaderField: "TOKEN")
        request.httpBody = httpBody
        request.httpMethod = "POST"
        return request
    }
    
    private func taskResume<T: Decodable>(from request: URLRequest,
                                          type: T.Type,
                                          onCompletion: @escaping(Result<T, NetworkResponse>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                
                guard let `self` = self else { return }
                if error != nil {
                    onCompletion(.failure(NetworkResponse.failed))
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            onCompletion(.failure(NetworkResponse.noData))
                            return
                        }
                        
                        do {
                            let apiResponse = try JSONDecoder().decode(type, from: responseData)
                            onCompletion(.success(apiResponse))
                        } catch {
                            onCompletion(.failure(NetworkResponse.unableToDecode))
                        }
                        
                    case .failure(let failureError):
                        onCompletion(.failure(failureError))
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResult<NetworkResponse> {
        switch response.statusCode {
        case 200...299 : return .success
        case 400 : return .failure(NetworkResponse.responseFromTheServer)
        case 401 : return .failure(NetworkResponse.authenticationError)
        case 500 : return .failure(NetworkResponse.failed)
        default: return .failure(NetworkResponse.badRequest)
        }
    }
}

extension NetworkService: NetworkServiceOutput {
    
    func getAllCompanies(onCompletion: @escaping (Result<[ResponseItem], NetworkResponse>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "dev.bonusmoney.pro"
        urlComponents.path = "/mobileapp/getAllCompanies"

        
        guard let url = urlComponents.url,
              let request = self.createRequest(from: url) else { return }
        
        taskResume(from: request, type: [ResponseItem].self) { result in
            switch result {
            case .success(let items):
                onCompletion(.success(items))
            case .failure(let failureError): 
                onCompletion(.failure(failureError))
            }
        }
    }

}
