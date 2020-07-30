//
//  CoinManager.swift
//  ByteCoin


import Foundation

protocol CoinModelDelegate {
    func DidUpdateModel(_ coinmodel : CoinModel)
    func DidFailWithError (_ error :Error)
}


struct CoinManager {
//     https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=3FF0D1D8-9510-4AD5-ACD3-5F932CC8BEBB
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey = "?apikey=3FF0D1D8-9510-4AD5-ACD3-5F932CC8BEBB"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate : CoinModelDelegate? = nil
    
    func fetchCoinRate(_ currency :String) {
         let urlString = "\(baseURL)\(currency)/USD\(apiKey)"
    
        performRequest(with : urlString )
        
    }
    func performRequest(with urlString : String) {
         if let url = URL (string: urlString)
         {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url){ (data, response, error) in
            if error !=  nil {
                self.delegate?.DidFailWithError(error!)
            }
            else {
                
                 if let safeData = data{
                    if let coinmodel = self.parseJson(safeData){
                    self.delegate?.DidUpdateModel(coinmodel)
                    }
                    
                }
            }
            
        }
        task.resume()
        }
        
    }
    
    func parseJson( _ safeData : Data ) -> CoinModel?
    {
        let decoder = JSONDecoder()
        do {
            let parsedData = try decoder.decode(DecodedData.self, from: safeData)
//            print(parsedData.rate)
            let  coinmodel = CoinModel(rate: parsedData.rate)
                 return coinmodel
                
        }
        catch{
            delegate?.DidFailWithError(error)
            return nil
        }
    
    }
    
}

