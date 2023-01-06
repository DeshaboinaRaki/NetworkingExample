//
//  CardModel.swift
//  NetworkingExample
//
//  Created by rakeshDeshaboina on 05/01/23.
//

import Foundation
struct CardModel:Codable{
    let data: [CardDetails]?
    enum CodingKeys:String,CodingKey {
        case data = "data"
    }
}

struct CardDetails:Codable{
    let id: Int?
    let name: String?
    let type: String?
    let desc: String?
    let race: String?
    let archetype: String?
    let cardSet:[CardSet]?
    let cardImages:[CardImages]?
    let cardPrices:[CardPrice]?
    
    enum CordingKeys:String,CodingKey{
        case id = "id"
        case name = "name"
        case type = "type"
        case desc = "desc"
        case race = "race"
        case archetype = "archetype"
        case cardSet = "card_sets"
        case cardImages = "card_images"
        case cardPrices = "card_prices"
    }
}
struct CardSet:Codable{
    let setName: String?
    let setCode: String?
    let setRarity: String?
    let setRarityCode: String?
    let setPrice: String?
    
    enum CodingKeys: String, CodingKey {
            case setName = "set_name"
            case setCode = "set_code"
            case setRarity = "set_rarity"
            case setRarityCode = "set_rarity_code"
            case setPrice = "set_price"
        }
    
}
struct CardImages:Codable{
    let id: Int?
    let imageUrl:String?
    let imageUrlSmall:String?
    let imageUrlChopped:String?
    
    enum CodingKeys:String,CodingKey {
    case id = "id"
        case imageUrl = "image_url"
        case imageUrlSmall = "image_url_small"
        case imageUrlChopped = "image_url_croppped"
        
    }
    
}
struct CardPrice:Codable{
    let marketprice:String?
    let tcgPrice:String?
    let ebayPrice:String?
    let amazonPrice:String?
    let coolStuffnicPrice:String?
    
    enum CodingKeys:String,CodingKey {
    case marketprice = "cardmarket_price"
        case tcgPrice = "tcgplayer_price"
        case ebayPrice = "ebay_price"
        case amazonPrice = "amazon_price"
        case coolStuffnicPrice = "coolstuffinc_price"
    }
    
}



//"data": [
//        {
//            "id": 34541863,
//            "name": "\"A\" Cell Breeding Device",
//            "type": "Spell Card",
//            "desc": "During each of your Standby Phases, put 1 A-Counter on 1 face-up monster your opponent controls.",
//            "race": "Continuous",
//            "archetype": "Alien",
//            "card_sets": [
//                {
//                    "set_name": "Force of the Breaker",
//                    "set_code": "FOTB-EN043",
//                    "set_rarity": "Common",
//                    "set_rarity_code": "(C)",
//                    "set_price": "1.31"
//                }
//            ],
//            "card_images": [
//                {
//                    "id": 34541863,
//                    "image_url": "https://images.ygoprodeck.com/images/cards/34541863.jpg",
//                    "image_url_small": "https://images.ygoprodeck.com/images/cards_small/34541863.jpg",
//                    "image_url_croppped": "https://images.ygoprodeck.com/images/cards_cropped/34541863.jpg"
//                }
//            ],
//            "card_prices": [
//                {
//                    "cardmarket_price": "0.17",
//                    "tcgplayer_price": "0.19",
//                    "ebay_price": "4.99",
//                    "amazon_price": "24.45",
//                    "coolstuffinc_price": "0.25"
//                }
//            ]
