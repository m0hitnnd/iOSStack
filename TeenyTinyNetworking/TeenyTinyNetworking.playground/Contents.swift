
import Foundation
import PlaygroundSupport

struct AnyEncodable: Encodable {
    let body: Encodable
    init(_ body: Encodable) {
        self.body = body
    }
    
    func encode(to encoder: Encoder) throws {
        try body.encode(to: encoder)
    }
}

enum HttpMethod {
    case get
    case post(body: AnyEncodable)
    
    func toUrlRequestHttpMethod() -> String {
        switch self {
        case .get:
            return "get"
        case .post:
            return "post"
        }
    }
}

struct Request {
    let method: HttpMethod
    let url: String
}

extension Request {
    init(url: String) {
        self.url = url
        self.method = .get
    }
}

private extension Request {
    func toURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = self.method.toUrlRequestHttpMethod()
        switch method {
        case .get: ()
        case .post(let body):
            request.httpBody = try! JSONEncoder().encode(body)
        }
        return request
    }
}


struct WebService {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func execute<T: Decodable>(_ request: Request, responseType: T.Type, completionHandler: @escaping ((T?) -> ())) {
        urlSession.dataTask(with: request.toURLRequest()) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil)
                return
            }
            completionHandler(try? JSONDecoder().decode(responseType, from: data))
        }.resume()
    }
}


// Response Model
struct PopularMovies: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}




PlaygroundPage.current.needsIndefiniteExecution = true

let webService = WebService()
let request = Request(url: "http://api.themoviedb.org/3/movie/popular?api_key=34af88c261175ffccdb66245eb02bea2")
webService.execute(request, responseType: PopularMovies.self) { (data) in
    print(data!)
}
