//
//  NetworkAPIClient.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 02/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkService {
    @discardableResult
    func dataRequest<T: Decodable>(_ endPoint: APIEndPoint, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask
    
    @discardableResult
    func downloadRequest(_ url: URL, size: CGSize, scale: CGFloat, completion: @escaping (Result<UIImage, NetworkError>) -> Void) -> URLSessionDownloadTask
}

final class NetworkAPIClient: NetworkService {

    private let session: URLSession

    static var defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        if #available(iOS 11.0, *) {
            configuration.waitsForConnectivity = true
        }
        return URLSession(configuration: configuration)
    }()

    init(session: URLSession = NetworkAPIClient.defaultSession) {
        self.session = session
    }

    //MARK: DataRequest
    @discardableResult
    func dataRequest<T: Decodable>(_ endPoint: APIEndPoint, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask {

        var request: URLRequest
        do {
            request = try endPoint.asURLRequest()
        } catch {
            completion(.failure(error as! NetworkError))
            return URLSessionDataTask()
        }

        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                completion(Result.failure(NetworkError.apiError(error)))
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(Result.failure(NetworkError.emptyData))
                return
            }
            guard response.statusCode == 200 else {
                completion(Result.failure(NetworkError.invalidStatusCode(response.statusCode)))
                return
            }
            
            self.printJSON(data: data)
            
            do {
                let jsonObject = try JSONDecoder().decode(objectType, from: data)
                completion(Result.success(jsonObject))
            } catch {
                completion(Result.failure(NetworkError.decodingError(error as! DecodingError)))
            }
        }
        dataTask.resume()
        return dataTask
    }

    //MARK: DataRequest
    @discardableResult
    func downloadRequest(_ url: URL, size: CGSize, scale: CGFloat, completion: @escaping (Result<UIImage, NetworkError>) -> Void) -> URLSessionDownloadTask {
        let downloadTask = self.session.downloadTask(with: url) { (location: URL?, response: URLResponse?, error: Error?) in
            if let error = error {
                completion(.failure(.apiError(error)))
                return
            }
            guard let location = location else {
                completion(Result.failure(.emptyData))
                return
            }
            guard let downloadedImage = self.downsampleImage(from: location, pointSize: size, scale: scale) else {
                if let data = try? Data(contentsOf: location), let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(.emptyData))
                }
                return
            }
            completion(.success(downloadedImage))
        }
        downloadTask.resume()
        return downloadTask
    }
    
    func downsampleImage(from url: URL, pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, imageSourceOptions) else {
            return nil
        }
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
             kCGImageSourceCreateThumbnailFromImageAlways: true,
             kCGImageSourceShouldCacheImmediately: true,
             kCGImageSourceCreateThumbnailWithTransform: true,
             kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
        guard let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        return UIImage(cgImage: downSampledImage)
    }
}


extension NetworkAPIClient {
    func printJSON(data: Data) {
        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = String.init(data: jsonData, encoding: .utf8)
        print(string ?? "")
    }
}
