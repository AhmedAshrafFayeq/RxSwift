//
//  NetworkModel.swift
//  Rx Swift Sample
//
//  Created by JETS Mobil Lab -  on 5/27/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire



class NetworkModel {
    
    var disposeBag = DisposeBag()
    var listOfRates = [Rates] ()
    var arrayResult = [[String:AnyObject]]()

    
    var homePresenter : HomePresenter?
    
    func setDelegate (delegate : HomePresenter){
        self.homePresenter = delegate
    }
 
    func fetchJSON(url : String )  {
        RxAlamofire.requestJSON(.get, url)
            .subscribe(onNext: { [weak self] (r, json) in
                if let dict = json as? [String: AnyObject] {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                        let rates = try! JSONDecoder().decode(
                            Rates.self, from: data)
                        self?.homePresenter?.sendRates(myrates: rates)
                        print(rates)
                    } catch let myJSONError {
                        print(myJSONError)
                    }

                }else {
                    print("no")
                }}, onError: { (error) in
                    print(error)
                
            }, onCompleted: {
                
            }) {
                print("Disposed")
        }.disposed(by: disposeBag)
    }
}

