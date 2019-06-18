//
//  HomePresenter.swift
//  Rx Swift Sample
//
//  Created by JETS Mobil Lab -  on 5/26/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation

class HomePresenter{
    
    let network : NetworkModel = NetworkModel()
    var HomeDelegate : HomeDelegate?
    var countryList :[String]=[]
    var valueList : [Double]=[]
//    var movies = Array<NSManagedObject>()
    
    
    init() {
        
    }
    func setDelegate(delegate : HomeDelegate)
    {
        self.HomeDelegate = delegate
    }

    func fetchData() {
        network.setDelegate(delegate: self)
        network.fetchJSON(url: "https://api.exchangeratesapi.io/latest")
        
    }
    func sendRates(myrates : Rates)  {
        
        var dict = myrates.rates
        for item in dict{
            countryList.append(item.key)
            valueList.append(item.value)
        }
        
        HomeDelegate?.getRates(countryList: countryList, valueList: valueList)
        
    }
}
