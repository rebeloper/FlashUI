//
//  File.swift
//  
//
//  Created by Alex Nagy on 01/03/2020.
//

import SwiftUI
import SDWebImageSwiftUI

public struct EditableWebImageView: View {
    
    public var imageUrl: String
    public var placeholderImage: Image
    public var size: CGSize
    
    @Binding public var isShowingImagePicker: Bool
    @Binding public var selectedImage: UIImage
    @Binding public var didSelectImage: Bool
    
    public var isCircle: Bool
    
    public var cameraImage = Image(systemName: "camera")
    public var cameraImageColor = Color(.black)
    public var cameraImageSize: CGSize = CGSize(width: 20, height: 20)
    public var rectangleImageViewCornerRadius: CGFloat = 10
    
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

