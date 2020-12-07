//
//  ContrySummaryStruct.swift
//  Covid19-LookUp
//
//  Created by Kary Martinez on 12/7/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import Foundation

struct CovidCountriesWrapper: Codable {
    let countries: [CountrySummary]
    
    enum CodingKeys: String, CodingKey {
        case countries = "Countries"
    }
}

struct CountrySummary: Codable {
    let country: String
    let totalConfirmed: Int
    let totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case totalConfirmed = "TotalConfirmed"
        case totalRecovered = "TotalRecovered"
    }
}
