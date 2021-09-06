//
//  CoreDataError.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/1.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation


/// CoreData Error
///
/// - saveFailed: save failed
/// - deleteFailed: failed to delete 
public  enum CoreDataError:Error {
    case saveFailed(Error)
    case deleteFailed(Error)
}
