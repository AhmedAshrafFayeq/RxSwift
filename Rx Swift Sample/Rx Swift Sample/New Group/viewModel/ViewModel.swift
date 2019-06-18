//
//  ViewModel.swift
//  Rx Swift Sample
//
//  Created by JETS Mobil Lab -  on 5/29/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    
    var countryList :[String]=[]
    var valueList : [Double]=[]
    var apicall = APIClient()
    
    func fetchData(){
        apicall.executeAPICall(url: "https://api.exchangeratesapi.io/latest", httpMethod: HTTPServerMethod.get, parameters: nil, headers: nil, successHandler: {
            [weak self] (responseData) in
            
            
            
            
        }) { [weak self] (error) in
            
            
            
            
        }
    }
}
