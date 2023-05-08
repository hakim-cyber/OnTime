//
//  ScanView.swift
//  OnTime
//
//  Created by aplle on 5/9/23.
//



import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreImage
struct ScanView: View {
   
    var projects:[Project]
    
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        Form{
            let qrCodeData = try! JSONEncoder().encode(projects)
            let qrCodeImage = generateQRCode(from: qrCodeData)
            Image(uiImage: qrCodeImage)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
        }
    }
    func generateQRCode(from data: Data) -> UIImage {
            filter.setValue(data, forKey: "inputMessage")
            let outputImage = filter.outputImage!
            let context = CIContext()
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent)!
            return UIImage(cgImage: cgImage)
        }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView(projects: [Project(name: "name", description: "description", tasks: [Task]())])
    }
}
