//
//  FitCoding
//
//  Copyright (c) 2017-Present cyrill
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

extension NSObject {
    
    func codableProperties() -> Dictionary<String, Any?> {
        var codableProperties = [String: Any?]()
        let mirrorOfSelf = Mirror(reflecting: self)
        
        for item in mirrorOfSelf.children {
            if let label = item.label {
                codableProperties[label] = unwrap(item.value)
            }
        }
        return codableProperties
    }
    
    func unwrap(_ any: Any) -> Any? {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != Mirror.DisplayStyle.optional {
            return any
        }
        if mi.children.count == 0 { return nil } // Optional.None
        return mi.children.first?.value
    }
    
    public func setup(withDecoder aDecoder: NSCoder) {
        for (key, _) in codableProperties() {
            let object = aDecoder.decodeObject(forKey: key)
            setValue(object, forKey: key)
        }
    }
    
    public func setup(withCoder aCoder: NSCoder) {
        for (key, value) in codableProperties() {
            switch value {
            case let property as AnyObject:
                aCoder.encode(property, forKey: key)
            case let property as Int:
                aCoder.encode(Int64(property), forKey: key)
            case let property as Bool:
                aCoder.encode(property, forKey: key)
            default:
                print("Nil value for \(key)")
            }
        }
    }
}

