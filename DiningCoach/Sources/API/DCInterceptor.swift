//
//  DCInterceptor.swift
//  DiningCoach
//
//  Created by 이송미 on 2023/07/10.
//

import Foundation
import Alamofire

final class DCInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {        
        var urlRequest = urlRequest        
        urlRequest.headers.add(.accept("application/json"))
        urlRequest.headers.add(.contentType("application/json"))
        
        completion(.success(urlRequest))
    }
}
