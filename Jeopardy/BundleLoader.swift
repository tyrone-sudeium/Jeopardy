//
//  BundleLoader.swift
//  Jeopardy!
//
//  Created by Tyrone Trevorrow on 10/08/2014.
//  Copyright (c) 2014 Sudeium. All rights reserved.
//

import Foundation

class BundleLoader {
    class func availableBundles() -> [NSBundle] {
        // Find bundles in the main bundle
        let mainBundleBundlePaths: [String] = NSBundle.mainBundle().pathsForResourcesOfType("bundle", inDirectory: nil) as [String]
        let mainBundleBundles: [NSBundle] = mainBundleBundlePaths.map { return NSBundle(path: $0) }
        
        // Find bundles in the Documents folder
        let fm = NSFileManager.defaultManager()
        let docsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        var errorPtr: NSErrorPointer = nil
        let contents = fm.contentsOfDirectoryAtPath(docsFolder, error: errorPtr) as [String]
        let documentsBundles: [NSBundle] = contents.map { return NSBundle(path: $0) }
        
        return mainBundleBundles + documentsBundles
    }
}
