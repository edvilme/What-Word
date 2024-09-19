import UIKit

extension UIImage{
    
    func toCVPixelBuffer(format: OSType) -> CVPixelBuffer? {
            guard let cgImage = self.cgImage else { return nil }
            
            // Use the original size of the CGImage
            let originalWidth = Int(self.size.width)
            let originalHeight = Int(self.size.height)
            
            var pixelBuffer: CVPixelBuffer?
            let pixelBufferAttributes: [String: Any] = [
                kCVPixelBufferCGImageCompatibilityKey as String: true,
                kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
            ]
            
            let status = CVPixelBufferCreate(
                kCFAllocatorDefault,
                originalWidth,
                originalHeight,
                format,
                pixelBufferAttributes as CFDictionary,
                &pixelBuffer
            )
            
            guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
                print("Error: Could not create pixel buffer.")
                return nil
            }
            
            CVPixelBufferLockBaseAddress(buffer, .readOnly)
            
            let pixelData = CVPixelBufferGetBaseAddress(buffer)
            
            var colorSpace: CGColorSpace
            var bitmapInfo: UInt32
            
            if format == kCVPixelFormatType_OneComponent8 {
                // Grayscale (one component)
                colorSpace = CGColorSpaceCreateDeviceGray()
                bitmapInfo = CGImageAlphaInfo.none.rawValue
            } else {
                // Default to RGB
                colorSpace = CGColorSpaceCreateDeviceRGB()
                bitmapInfo = CGImageAlphaInfo.noneSkipFirst.rawValue
            }
            
            // Create CGContext with original image size and format-specific settings
            let context = CGContext(
                data: pixelData,
                width: originalWidth,
                height: originalHeight,
                bitsPerComponent: 8,
                bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                space: colorSpace,
                bitmapInfo: bitmapInfo
            )
            
            if let context = context {
                // Draw the image at its original size
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: originalWidth, height: originalHeight))
            } else {
                print("Error: Could not create context.")
                CVPixelBufferUnlockBaseAddress(buffer, .readOnly)
                return nil
            }
            
            CVPixelBufferUnlockBaseAddress(buffer, .readOnly)
            return buffer
        }
    
       public func fit(in size: CGSize, background: UIColor = UIColor.black) -> UIImage? {
           
           let rect = CGRect(origin: .zero, size: size)
           var scaledImageRect = CGRect.zero
        
           let aspectWidth:CGFloat = size.width / self.size.width
           let aspectHeight:CGFloat = size.height / self.size.height
           let aspectRatio:CGFloat = min(aspectWidth, aspectHeight)
        
           scaledImageRect.size.width = self.size.width * aspectRatio
           scaledImageRect.size.height = self.size.height * aspectRatio
           scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
           scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
        
           UIGraphicsBeginImageContextWithOptions(size, false, 0)
           background.setFill()
           UIRectFill(rect)
           self.draw(in: scaledImageRect)
           
           let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
            
           return scaledImage
      }
    
    func invert() -> UIImage {
        let beginImage = CIImage(image: self)
        if let filter = CIFilter(name: "CIColorInvert") {
            filter.setValue(beginImage, forKey: kCIInputImageKey)
            return UIImage(ciImage: filter.outputImage!)
        }
        return self
    }
}
