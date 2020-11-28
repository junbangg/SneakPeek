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
    
    var body: some View {
        VStack {
            
            if viewmodel.productDatasource == nil {
                Text("Loading...")
            }else {
//                Thumbnail(url: viewmodel.productDatasource!.thumbnail)
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 300)
                productDetails
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
            HStack {
                HStack {
                    Text("발매일")
                        .foregroundColor(.gray)
                    Text(viewmodel.productDatasource!.releaseDate)
                }
                HStack {
                    Text("정가")
                        .foregroundColor(.gray)
                    Text("\(viewmodel.productDatasource!.retailPrice)")
                }
                
            }
            Text(viewmodel.datasource.description)
        }
        
    }
}

//struct Product_Previews: PreviewProvider {
//    static var previews: some View {
//        Product()
//    }
//}
