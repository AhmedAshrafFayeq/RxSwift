
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController , UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBOutlet weak var onOffSwitch: UISwitch!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        onOffSwitch.rx.isOn.subscribe(onNext:
        {
            isChanged in
                print(isChanged)
        }).disposed(by: disposeBag)
        
        
        let items = Observable.of(["Hello 1","Hello 2","Hello 3", "Hello 4" , "Hello 5"])
        
        items.asObservable()
            .bind(to: self.mainCollectionView.rx.items(cellIdentifier: "textCell", cellType: MyCollectionViewCell.self))
            { (row , data , cell) in
                cell.nameLabel.text = data}
            .disposed(by: disposeBag)
        
        mainCollectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.bounds.width
        let height = (width - 35 ) / 3
        return CGSize(width: width, height: height)
    }
    
}

