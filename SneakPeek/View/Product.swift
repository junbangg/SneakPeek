//
//  Product.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/28.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import SwiftUI
import Combine
import SwiftKeychainWrapper

struct Product: View {
    @ObservedObject var viewmodel : SearchViewModel
    init(viewmodel: SearchViewModel) {
        self.viewmodel = viewmodel
    }
    
    let sizes : [String] = ["4", "4.5", "5", "5.5", "6", "6.5", "7", "7.5", "8", "8.5", "9", "9.5", "10", "10.5", "11", "11.5", "12", "12.5", "13", "13.5", "14", "14.5", "15", "15.5" ,"16", "16.5", "17", "17.5", "18"]
    @State private var size: Float = 4.0
//    @State private var size: Double = 0
    
    var body: some View {
        ScrollView{
            VStack {
                if viewmodel.productDatasource == nil {
                    Text("Loading...")
                }else {
                    Thumbnail(url: viewmodel.productDatasource!.thumbnail)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                    productDetails
                    HStack {
                        Stepper("Size", onIncrement: {
                            self.size += 0.5
                        }, onDecrement: {
                            self.size -= 0.5
                        })

                        Text(String(format: "%.1f", self.size))
                    }
                    .padding(.horizontal, 10)
//                    Text()
                    
                }
                
            }
        }
        .onAppear(perform: viewmodel.refresh)
        
    }
}

private extension Product {
    var productDetails : some View {
        VStack {
            HStack {
                Text("제품명")
                    .foregroundColor(.gray)
                Text(viewmodel.productDatasource!.shoeName)
            }
            .padding(.bottom, 20)
            HStack {
                HStack {
                    Text("발매일")
                        .foregroundColor(.gray)
                    Text(viewmodel.productDatasource!.releaseDate)
                }
                .padding(.horizontal, 10)
                Spacer()
                HStack {
                    Text("정가")
                        .foregroundColor(.gray)
                    Text("\(viewmodel.productDatasource!.retailPrice)")
                }
                .padding(.horizontal, 10)
                
            }
            .padding(.bottom, 20)
            Text(viewmodel.productDatasource!.description)
                .font(.caption)
                .padding(.horizontal, 10)
        }
        
    }
}

//struct Product_Previews: PreviewProvider {
//    static var previews: some View {
//        Product()
//    }
//}
