//
//  APICaller.swift
//  NetflixClone
//
//  Created by alkalemir on 2.12.2022.
//

import Foundation

struct Response: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let poster_path: String?
}

class APICaller {
    static let shared = APICaller()
    let api_key = "5a639d0663ea60f02d3165dbaf6438f9"
    let base_url = "https://api.themoviedb.org/3/movie/popular?api_key="
    
    func fetchPopulerMovies(completionHandler: @escaping ([Movie]) -> Void) {
        let url = "\(base_url)\(api_key)"
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            let result = try! JSONDecoder().decode(Response.self, from: data)
            completionHandler(result.results)
        }.resume()
    }
}
