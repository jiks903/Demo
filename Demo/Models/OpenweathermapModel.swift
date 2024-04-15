//
//  OpenweathermapModel.swift
//  Demo
//
//  Created by Jeegnesh Solanki on 15/04/24.
//

import Foundation

class AcharyaprashantmapModel : Decodable {
    let id : String?
    let title : String?
    let language : String?
    let thumbnail : Thumbnail?
    let mediaType : Int?
    let coverageURL : String?
    let publishedAt : String?
    let publishedBy : String?
    let backupDetails : BackupDetails?

}
struct BackupDetails : Decodable {
    let pdfLink : String?
    let screenshotURL : String?
}
struct Thumbnail : Decodable {
    let id : String?
    let version : Int?
    let domain : String?
    let basePath : String?
    let key : String?
    let qualities : [Int]?
    let aspectRatio : Float?
}
