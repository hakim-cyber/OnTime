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
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        Form{
            let jsonData = try! JSONEncoder().encode(projects)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            let qrCodeImage = generateQrCode(from: jsonString)
            Image(uiImage: qrCodeImage)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
        }
    }
    func generateQrCode(from string:String)-> UIImage{
           filter.message = Data(string.utf8)
           
           if let outputImage = filter.outputImage{
               if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                   
                  
                   return UIImage(cgImage: cgimg)
               }
           }
           return UIImage(systemName: "xmark.circle") ?? UIImage()
       }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView(projects: [Project(name: "name", description: "description", tasks: [Task]())])
    }
}
