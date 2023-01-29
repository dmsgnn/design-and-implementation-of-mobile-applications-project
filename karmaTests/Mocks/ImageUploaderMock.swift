//
//  ImageUploaderMock.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 29/01/23.
//

import Foundation
import SwiftUI

class ImageUploaderMock : ImageUploaderProtocol {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        
    }
    
    static func uploadCollectionImage(image: UIImage, completion: @escaping(String) -> Void){
        
    }
}
