//
//  Product.swift
//  SneakPeek
//
//  Created by Jun suk Bang on 2020/11/28.
//  Copyright © 2020 Jun suk Bang. All rights reserved.
//

import SwiftUI
import Combine

struct Product: View {
    @ObservedObject var viewmodel : ProductViewModel
    init(viewmodel: ProductViewModel) {
        self.viewmodel = viewmodel
    }
    
    var body: some View {
        VStack {
            Thumbnail(url: viewmodel.datasource!.thumbnail)
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
            productDetails
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
                Text(viewmodel.datasource!.shoeName)
            }
            HStack {
                HStack {
                    Text("발매일")
                        .foregroundColor(.gray)
                    Text(viewmodel.datasource!.releaseDate)
                }
                HStack {
                    Text("정가")
                        .foregroundColor(.gray)
                    Text("\(viewmodel.datasource!.retailPrice)")
                }
                
            }
            Text(viewmodel.datasource!.description)
        }
        
    }
}

//struct Product_Previews: PreviewProvider {
//    static var previews: some View {
//        Product()
//    }
//}
