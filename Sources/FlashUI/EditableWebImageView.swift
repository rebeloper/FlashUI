//
//  EditableWebImageView.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI
import SDWebImageSwiftUI

public struct EditableWebImageView: View {
    
    init(imageUrl: String,
         placeholderImage: Image,
         size: CGSize,
         isShowingImagePicker: Binding<Bool>,
         selectedImage: Binding<UIImage>,
         didSelectImage: Binding<Bool>,
         isCircle: Bool,
         cameraImage: Image = Image(systemName: "camera"),
         cameraImageColor: Color = Color(.black),
         cameraImageSize: CGSize = CGSize(width: 20, height: 20),
         rectangleImageViewCornerRadius: CGFloat = 10) {
        self.imageUrl = imageUrl
        self.placeholderImage = placeholderImage
        self.isShowingImagePicker = isShowingImagePicker
        self.selectedImage = selectedImage
        self.didSelectImage = didSelectImage
        self.isCircle = isCircle
        self.cameraImage = cameraImage
        self.cameraImageColor = cameraImageColor
        self.cameraImageSize = cameraImageSize
        self.rectangleImageViewCornerRadius = rectangleImageViewCornerRadius
    }
    
    var imageUrl: String
    var placeholderImage: Image
    var size: CGSize
    
    @Binding var isShowingImagePicker: Binding<Bool>
    @Binding var selectedImage: Binding<UIImage>
    @Binding var didSelectImage: Binding<Bool>
    
    var isCircle: Bool
    
    var cameraImage: Image
    var cameraImageColor: Color
    var cameraImageSize: CGSize
    var rectangleImageViewCornerRadius: CGFloat
    
    public var body: some View {
        HStack {
            Spacer()
            ZStack {
                
                if isCircle {
                    WebImage(url: URL(string: self.imageUrl))
                        .onSuccess { image, cacheType in
                            print("Retreived image from cacheType: \(cacheType.rawValue)")
                    }
                    .onFailure(perform: { (err) in
                        print("Failed to retreive image with err: \(err)")
                    })
                        .resizable()
                        .placeholder(placeholderImage)
                        .indicator(.activity)
                        .modifier(CircularImageViewModifier(width: size.width, didSelectImage: self.$didSelectImage))
                    
                    if self.didSelectImage {
                        Image(uiImage: self.selectedImage)
                            .resizable()
                            .modifier(CircularImageViewModifier(width: size.width, didSelectImage: self.$didSelectImage))
                    }
                } else {
                    WebImage(url: URL(string: self.imageUrl))
                        .onSuccess { image, cacheType in
                            print("Retreived image from cacheType: \(cacheType.rawValue)")
                    }
                    .onFailure(perform: { (err) in
                        print("Failed to retreive image with err: \(err)")
                    })
                        .resizable()
                        .placeholder(placeholderImage)
                        .indicator(.activity)
                        .modifier(RectangleImageViewModifier(size: size,
                                                             cornerRadius: rectangleImageViewCornerRadius,
                                                             didSelectImage: self.$didSelectImage))
                    
                    if self.didSelectImage {
                        Image(uiImage: self.selectedImage)
                            .resizable()
                            .modifier(RectangleImageViewModifier(size: size,
                                                                 cornerRadius: rectangleImageViewCornerRadius,
                                                                 didSelectImage: self.$didSelectImage))
                    }
                }
                
                Button(action: {
                    self.isShowingImagePicker = true
                }, label: {
                    ZStack {
                        Spacer().frame(width: size.width, height: isCircle ? size.width : size.height)
                        cameraImage
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(self.didSelectImage ? .clear : cameraImageColor)
                            .frame(width: cameraImageSize.width, height: cameraImageSize.height)
                    }
                }).sheet(isPresented: self.$isShowingImagePicker, content: {
                    ImagePickerView(delegate: ImagePickerView.Delegate(didCancel: {
                        self.isShowingImagePicker = false
                    }, didSelect: { (uiImage) in
                        self.isShowingImagePicker = false
                        self.didSelectImage = true
                        self.selectedImage = uiImage
                    }))
                })
            }
            Spacer()
        }
    }
}

