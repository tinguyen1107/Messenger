//
//  ImagePicker.swift
//  Messenger
//
//  Created by Trọng Tín on 02/09/2021.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var uiImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var uiImage: UIImage?
        
        init(presentationMode: Binding<PresentationMode>, uiImage: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _uiImage = uiImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            presentationMode.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { presentationMode.dismiss() }
        
    }
    
    func makeCoordinator() -> Coordinator { return Coordinator(presentationMode: presentationMode, uiImage: $uiImage) }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
}
