/*:
# MANAGING TEMPORARY FILES
File management is quite powerful but it still requires a lot of care taking
when managing temporary files.

The below piece of code by Victor shows us how to enable better management
of temporary files.

## Author
[Victor Pavlychko](https://github.com/victor-pavlychko)

## Resource
[https://medium.com/@victor.pavlychko/managing-temporary-files-in-swift-b076e1444c76](https://medium.com/@victor.pavlychko/managing-temporary-files-in-swift-b076e1444c76)
*/


import Foundation

public protocol ManagedURL {
	var contentURL: URL { get }
	func keepAlive()
}

public extension ManagedURL {
	public func keepAlive() {}
}

extension URL: ManagedURL {
	public var contentURL: URL { return self }
}

public final class TemporaryFileURL: ManagedURL {
	public let contentURL: URL
	
	public init(extension ext: String) {
		contentURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString).appendingPathExtension(ext)
	}
	
	deinit {
		DispatchQueue.global(qos: .utility).async { [contentURL = self.contentURL] in
			try? FileManager.default.removeItem(at: contentURL)
		}
	}
}
