//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 21/03/2024.
//

import Foundation


/*
 Sample data
 
 struct Market: Codable {
     let data: DataClass
 }

 // MARK: - DataClass
 {
   "data": {
     "active_cryptocurrencies": 13437,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1023,
     "total_market_cap": {
       "btc": 39510147.38332708,
       "eth": 762652824.4476339,
       "ltc": 31064172336.320065,
       "bch": 6654171383.503118,
       "bnb": 4784201219.720881,
       "eos": 2632687602257.143,
       "xrp": 4289937219625.036,
       "xlm": 20260065756673.527,
       "link": 144167337111.8635,
       "dot": 281898585150.7439,
       "yfi": 298304271.6649556,
       "usd": 2580616798052.796,
       "aed": 9478347437568.121,
       "ars": 2201901244339204.8,
       "aud": 3923443329536.367,
       "bdt": 283245578496059.3,
       "bhd": 972644793653.2888,
       "bmd": 2580616798052.796,
       "brl": 12837794385273.238,
       "cad": 3482400435048.353,
       "chf": 2287574857549.9087,
       "clp": 2505856329413206.5,
       "cny": 18578634514221.473,
       "czk": 59607600344166.1,
       "dkk": 17632330076225.926,
       "eur": 2364417883945.5273,
       "gbp": 2019340386326.7083,
       "gel": 6993471522723.09,
       "hkd": 20188965202374.43,
       "huf": 933166933355981.9,
       "idr": 40423056788770240,
       "ils": 9433006000426.31,
       "inr": 214454316507728.12,
       "jpy": 389109271735597.7,
       "krw": 3436934096053539.5,
       "kwd": 793382247776.5541,
       "lkr": 784173435441076.4,
       "mmk": 5419976014235421,
       "mxn": 43039085672451.9,
       "myr": 12234704239568.295,
       "ngn": 3821893477916191,
       "nok": 27309932098005.28,
       "nzd": 4246219136786.4023,
       "php": 144665506773642.66,
       "pkr": 718701778257703.1,
       "pln": 10197660822006.959,
       "rub": 238064281529675,
       "sar": 9678585236779.412,
       "sek": 26824001954931.93,
       "sgd": 3456116852960.187,
       "thb": 92953817065861.86,
       "try": 83539693438546.89,
       "twd": 82059655511910.6,
       "uah": 101030022494843.12,
       "vef": 258397159989.0262,
       "vnd": 63973490423728620,
       "zar": 48190936145880.01,
       "xdr": 1938208374812.7258,
       "xag": 101052050639.83104,
       "xau": 1182128942.8520253,
       "bits": 39510147383327.08,
       "sats": 3951014738332708
     },
     "total_volume": {
       "btc": 2954421.025735065,
       "eth": 57028325.35712462,
       "ltc": 2322862605.5748515,
       "bch": 497574044.8025311,
       "bnb": 357744670.9514266,
       "eos": 196862530803.48697,
       "xrp": 320785457917.377,
       "xlm": 1514971930465.3943,
       "link": 10780294182.533564,
       "dot": 21079321699.664883,
       "yfi": 22306077.568453643,
       "usd": 192968870846.31918,
       "aed": 708755365731.4463,
       "ars": 164649938400714.34,
       "aud": 293380415760.0723,
       "bdt": 21180044823330.188,
       "bhd": 72730739297.46092,
       "bmd": 192968870846.31918,
       "brl": 959962241799.1836,
       "cad": 260400877919.21106,
       "chf": 171056290717.36526,
       "clp": 187378562657901.34,
       "cny": 1389240791883.904,
       "czk": 4457233379613.565,
       "dkk": 1318479685851.173,
       "eur": 176802324784.55618,
       "gbp": 150998720343.8574,
       "gel": 522945639993.526,
       "hkd": 1509655296980.7183,
       "huf": 69778732579242.164,
       "idr": 3022684976154311.5,
       "ils": 705364902670.6747,
       "inr": 16036091579284.84,
       "jpy": 29096135799514.28,
       "krw": 257001075165092.25,
       "kwd": 59326156684.121574,
       "lkr": 58637556145074.62,
       "mmk": 405285531842742.6,
       "mxn": 3218301830297.985,
       "myr": 914865416682.3986,
       "ngn": 285786897723398.75,
       "nok": 2042134564038.4038,
       "nzd": 317516383218.91626,
       "php": 10817545446338.385,
       "pkr": 53741830530699.86,
       "pln": 762542929884.5364,
       "rub": 17801556445840.734,
       "sar": 723728399327.0233,
       "sek": 2005798525658.0415,
       "sgd": 258435489969.64142,
       "thb": 6950738727884.429,
       "try": 6246785778441.735,
       "twd": 6136114078665.065,
       "uah": 7554647159205.717,
       "vef": 19321973037.841923,
       "vnd": 4783698308280239,
       "zar": 3603537937176.2437,
       "xdr": 144931972013.31995,
       "xag": 7556294341.48724,
       "xau": 88395180.35728194,
       "bits": 2954421025735.065,
       "sats": 295442102573506.5
     },
     "market_cap_percentage": {
       "btc": 49.75870032895319,
       "eth": 15.681720105067376,
       "usdt": 4.07645996377301,
       "bnb": 3.2074480720831167,
       "sol": 3.099839211147119,
       "xrp": 1.2777275450175132,
       "steth": 1.2760387970795009,
       "usdc": 1.225439332040367,
       "ada": 0.8468060765893469,
       "avax": 0.811757661002964
     },
     "market_cap_change_percentage_24h_usd": 1.0278840354187224,
     "updated_at": 1710961265
   }
 }
 */

struct MarketGlobalData: Codable {
    let data: MarketDataModel
}

// MARK: - DataClass
struct MarketDataModel: Codable {
 
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double


    enum CodingKeys: String, CodingKey {
  
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"

    }
    
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
   
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return  "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
    
    
    
}
