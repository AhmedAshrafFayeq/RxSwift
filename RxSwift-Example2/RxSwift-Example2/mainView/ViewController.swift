//
//  ViewController.swift
//  RxSwift-Example2
//
//  Created by Sally on 5/24/19.
//  Copyright © 2019 Sally Ahmed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var labelTxt: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var debounceBtn: UIButton!
    @IBOutlet weak var throttleBtn: UIButton!
    @IBOutlet weak var onOffSwitch: UISwitch!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    
    var flag = true

    override func viewDidLoad() {
        super.viewDidLoad()
//        let items = Observable.just(
//            (0..<20).map{ "Example \($0)" }
//        )
        
        debounceBtn.rx
            .tap.debounce(2,scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { (_) in
                print("debounce btn Taped")
            }).disposed(by: disposeBag)
        
        
        throttleBtn.rx.tap.throttle(2, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { (_) in
                print("throttle Btn Taped")
            }).disposed(by: disposeBag)
        

        mainCollectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
        onOffSwitch.rx.isOn.subscribe(onNext: { isChanged in
            print(isChanged)
            //self.mainCollectionView.
            if isChanged == true{
                self.flag = true
                self.mainCollectionView.reloadData()
            }
            else {
                self.flag = false
                self.mainCollectionView.reloadData()
            }
            
        }).disposed(by: disposeBag)
        
        
        
        _ = textField.rx.controlEvent(.editingChanged).asObservable().throttle(0.5,scheduler: MainScheduler.asyncInstance)
            .map{
                self.textField.text
            }.distinctUntilChanged().subscribe(onNext: { (val) in
                self.labelTxt.text="we are searching for \(val!)"
            }).disposed(by: disposeBag)
        //labelTxt.rx.text.distinctiUntilChanged()
        
        
        
        let items = Observable.of(["cr1.jpg","cr2.jpg","cr3.jpg", "cr4.jpg" , "cr5.jpg"])

        items.asObservable()
            .bind(to: self.mainCollectionView.rx.items(cellIdentifier: "cell", cellType: MyCollectionViewCell.self))
            { (row , data , cell) in
//                cell.img = UIImage(named:data)}
                cell.img.image = UIImage(named: data)
            }
           // cell.titleLbl.text = data}
            .disposed(by: disposeBag)
        
//        self.mainTableView
//            .rx
//            .modelSelected(String.self)
//            .subscribe(onNext: { [weak self] (value) in
//            let alert = UIAlertController(title: "", message: value, preferredStyle: .alert)
//            let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
//            alert.addAction(action)
//            self?.present(alert, animated: true, completion: nil)
//        }).disposed(by: disposeBag)

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if flag{
            return CGSize(width: 50, height: 50)
        }
        else{
            return CGSize(width: 20, height: 20)
        }
        
        
        
        
    }
    
  

}

