//
//  HomeViewController.swift
//  Rx Swift Sample
//
//  Created by JETS Mobil Lab -  on 5/28/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift

class HomeViewController: UIViewController {
    var  disposeBag = DisposeBag()
    var homePresenter : HomePresenter = HomePresenter()
    var countryList :[String]=[]
    var valueList : [Double]=[]
    
    var viewModel : ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData()
//        homePresenter.setDelegate(delegate: self)
//        
//        homePresenter.fetchData()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var myTableView: UICollectionView!
    
   

}
