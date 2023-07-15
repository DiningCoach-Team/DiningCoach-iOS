//
//  DietRecordDetailImageList.swift
//  DiningCoach
//
//  Created by 심현석 on 2023/07/14.
//

import SwiftUI

struct DietRecordDetailImageList: View {
    @EnvironmentObject var store: DietRecordStore
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FoodImageView(index: 0)
                FoodImageView(index: 1)
                FoodImageView(index: 2)
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
    }
}

struct FoodImageView: View {
    @EnvironmentObject var store: DietRecordStore
    @State private var showingImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    var index: Int
    
    var body: some View {
        VStack {
            if store.foodImageList.indices.contains(index) {
                store.foodImageList[index]
                    .resizable()
            } else {
                VStack(spacing: 8) {
                    Text("사진 추가")
                        .font(.pretendard(weight: .semiBold, size: 14))
                    Image(systemName: "plus")
                        .frame(width: 24, height: 24)
                }
                .foregroundColor(.neutral300)
                .frame(width: 150, height: 150)
                .background(Color.neutral50)
            }
        }
        .frame(width: 150, height: 150)
        .cornerRadius(12)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $inputImage)
        }
        .onTapGesture {
            if store.isEditMode {
                self.showingImagePicker = true
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        if store.foodImageList.isEmpty {
            store.foodImageList.append(image!)
        } else if !store.foodImageList.indices.contains(1) {
            store.foodImageList.append(image!)
        } else if !store.foodImageList.indices.contains(2) {
            store.foodImageList.append(image!)
        } else {
            store.foodImageList[index] = image!
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) { }
}
