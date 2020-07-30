

import UIKit

class ViewController: UIViewController {

    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate  = self
        
    }

    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
}


//MARK: - UIPickerVieaDataSource

extension ViewController : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return coinManager.currencyArray[row]
       }
    
}

//MARK: - UIPickerViewDelegate

extension ViewController : UIPickerViewDelegate
{
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.fetchCoinRate(coinManager.currencyArray[row])
        currencyLabel.text = coinManager.currencyArray[row]
    }
    
    
}
  //MARK: - CoinModelDelegate

extension ViewController : CoinModelDelegate
{
    func DidUpdateModel(_ coinmodel: CoinModel) {
    DispatchQueue.main.async {
        self.bitCoinLabel.text = coinmodel.rateString
            print(coinmodel.rateString)
        }
    }
    
    func DidFailWithError(_ error: Error) {
        print(error)
        
    }
    
    
}

