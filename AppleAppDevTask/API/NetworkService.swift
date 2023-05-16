//
//  NetworkService.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 11.05.2023.
//

import Foundation

enum NetworkResponse: LocalizedError {
    
    case badRequest(String)
    case unauthorized
    case internalServerError
    
    var errorDescription: String? {
        switch self {
        case .badRequest(let massage):
            return NSLocalizedString(massage, comment: "")
        case .unauthorized:
            return NSLocalizedString("ошибка авторизации", comment: "")
        case .internalServerError:
            return NSLocalizedString("все упало", comment: "")
        }
    }
}

protocol NetworkServiceOutput {
    func getAllCompanies(onCompletion: @escaping (Result<[ResponseItem], NetworkResponse>) -> Void)
}

final class NetworkService {
    
    private enum NetworkResult<Error> {
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
    
    private func taskResume(from request: URLRequest,
                            onCompletion: @escaping(Result<[ResponseItem], NetworkResponse>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil,
                      let response = response as? HTTPURLResponse,
                      let data = data else {
                    print(error!.localizedDescription)
                    return
                }
                
                switch response.statusCode {
                case 200:
                    do {
                        let apiResponse = try JSONDecoder().decode([ResponseItem].self, from: data)
                        onCompletion(.success(apiResponse))
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                case 400:
                    do {
                        let message = try JSONDecoder().decode(MassegeFromServer.self, from: data)
                        onCompletion(.failure(.badRequest(message.message)))
                    } catch {
                        print(error.localizedDescription)
                    }
                case 401: onCompletion(.failure(.unauthorized))
                case 500: onCompletion(.failure(.internalServerError))
                default: break
                }
                
            }
        }
        task.resume()
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
        
        taskResume(from: request) { result in
            switch result {
            case .success(let items):
                onCompletion(.success(items))
            case .failure(let failureError):
                onCompletion(.failure(failureError))
            }
        }
    }
    
}
