//
// Copyright (c) 2018 Adyen B.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Foundation

/// This function should be invoked from the application's delegate when the application is opened through a URL.
///
/// - Parameter url: The URL through which the application was opened.
/// - Returns: A boolean value indicating whether the URL was handled by the Adyen SDK.
@discardableResult
public func applicationDidOpen(_ url: URL) -> Bool {
    return RedirectListener.applicationDidOpen(url)
}

/// Shared class that listens to the return of the shopper after a redirect.
internal final class RedirectListener {

    // MARK: - Registering for URLs
    
    /// A typealias for a closure that handles a URL through which the application was opened.
    internal typealias URLHandler = (URL) -> Void
    
    /// Sets a handler that will be invoked when the application is opened.
    /// The handler will only be invoked once. Only one handler can be registered at the same time.
    ///
    /// - Parameter handler: The handler to invoke when the application is opened.
    internal static func registerForURL(using handler: @escaping URLHandler) {
        urlHandler = handler
    }
    
    private static var urlHandler: URLHandler?
    
    // MARK: - Handling a URL
    
    /// Should be invoked when the application is opened through a URL.
    ///
    /// - Parameter url: The URL through which the application was opened.
    /// - Returns: A boolean value indicating whether the URL was handled by the RedirectListener.
    internal static func applicationDidOpen(_ url: URL) -> Bool {
        guard let urlHandler = urlHandler else {
            return false
        }
        
        urlHandler(url)
        
        return true
    }
    
}
