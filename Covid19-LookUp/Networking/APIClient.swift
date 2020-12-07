//
//  APIClient.swift
//  Covid19-LookUp
//
//  Created by Kary Martinez on 12/7/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import Foundation

struct APIClient {
    func fetchCovidData(completion: @escaping (Result<[CountrySummary], Error>) -> ()) {
      
      let endpointURLString = "https://api.covid19api.com/summary"
      
      guard let url = URL(string: endpointURLString) else {
        print("bad url")
        return
      }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
             if let error = error {
               return completion(.failure(error))
             }
      
             guard let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) else {
               print("bad status code")
               return
             }
             
             if let jsonData = data {
               // convert data to our swift model
               do {
                 let countries = try JSONDecoder().decode(CovidCountriesWrapper.self, from: jsonData).countries
                 completion(.success(countries))
               } catch {
                 // decoding error
                 completion(.failure(error))
               }
             }
           }
           dataTask.resume()
         }
}
