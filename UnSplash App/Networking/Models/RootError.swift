// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let errorResponse = try? newJSONDecoder().decode(ErrorResponse.self, from: jsonData)

import Foundation

// MARK: - ErrorResponse
struct ErrorResponse :Decodable{
    let errors: [String]
}
