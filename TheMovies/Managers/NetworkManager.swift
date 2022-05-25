//
//  NetworkManager.swift
//  TheMovies
//
//  Created by apple on 18.05.2022.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    let key = "8983d582e6db4d50746d8e03ec9e79f5"
    func fetchCurrentFilms( complitionHeandler: @escaping (([Result]?) -> ())) {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(key)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let currentData = try decoder.decode(FilmModel.self, from: data)
                  complitionHeandler(currentData.results)
                   
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    func fetchCurrentVideo(id: String, complitionHeandler: @escaping ((String) -> ())) {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(key)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let currentData = try decoder.decode(TrailerModel.self, from: data)
                    guard let key = currentData.results?.first?.key else { return }
                    complitionHeandler(key)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
  
}
