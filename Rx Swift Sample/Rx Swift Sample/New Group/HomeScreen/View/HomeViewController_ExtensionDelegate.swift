//
//  HomeViewController_ExtensionDelegate.swift
//  Rx Swift Sample
//
//  Created by JETS Mobil Lab -  on 5/27/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift

extension HomeViewController : HomeDelegate
{
    func getRates(countryList :[String] , valueList : [Double]) {
        self.countryList = countryList
        self.valueList = valueList
        Observable.of(countryList).bind(to:(self.myTableView.rx.items(cellIdentifier: "Cell", cellType: CollectionViewCell.self ))){ [weak self] (row , element , cell) in
                cell.countryLabel?.text = element
                cell.valueLabel?.text = String(self!.valueList[row])
        }.disposed(by: disposeBag)

    }
 
}
