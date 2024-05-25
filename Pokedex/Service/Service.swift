//
//  Service.swift
//  Pokedex
//
//  Created by fgrmac on 21/05/24.
//

import Foundation

public protocol ServiceManager {
    
    func GET(from url: String, completionHandler: @escaping (Result<Data, Never>) -> Void ) async
    func POST(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void ) async
    func PUT(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void ) async
    func DELETE(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void ) async
    
}

class Service: ServiceManager {
    
    
    //MARK: - GET
    final func GET(from url: String, completionHandler: @escaping (Result<Data, Never>) -> Void) async {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return }
        
        let responseStatus = response as? HTTPURLResponse
        
        if responseStatus?.statusCode == 200 {
            
            completionHandler(.success(data))
            
        }
        
    }
    
    
    //MARK: - POST
    final func POST(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void) async {
        
    }
    
    
    //MARK: - PUT
    final func PUT(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void) async {
        
    }
    
    
    //MARK: - DELETE
    final func DELETE(from url: String, completionHandler: @escaping (Result<Bool, Never>) -> Void) async {
        
    }
    
}
