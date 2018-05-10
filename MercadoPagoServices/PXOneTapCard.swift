//
//  PXOneTapCard.swift
//  MercadoPagoServices
//
//  Created by Eden Torres on 09/05/2018.
//  Copyright © 2018 Mercado Pago. All rights reserved.
//

import Foundation
open class PXOneTapCard: NSObject, Codable {
    open var cardId: String
    open var cardDescription: String?
    open var issuer: PXIssuer?
    open var lastFourDigits: String?
    open var installments: Int?
    open var payerCosts: [PXPayerCost]?

    public init(cardId: String, cardDescription: String?, issuer: PXIssuer?, lastFourDigits: String?, installments: Int?, payerCosts: [PXPayerCost]?) {
        self.cardId = cardId
        self.cardDescription = cardDescription
        self.issuer = issuer
        self.lastFourDigits = lastFourDigits
        self.installments = installments
        self.payerCosts = payerCosts
    }

    public enum PXOneTapCardKeys: String, CodingKey {
        case cardId = "id"
        case cardDescription = "description"
        case issuer = "issuer"
        case lastFourDigits = "last_four_digits"
        case installments = "installments"
        case payerCosts = "payer_costs"
    }

    required public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PXOneTapCardKeys.self)
        let issuer: PXIssuer? = try container.decodeIfPresent(PXIssuer.self, forKey: .issuer)
        let payerCosts: [PXPayerCost]? = try container.decodeIfPresent([PXPayerCost].self, forKey: .payerCosts)
        let cardId: String = try container.decode(String.self, forKey: .cardId)
        let cardDescription: String? = try container.decodeIfPresent(String.self, forKey: .cardDescription)
        let lastFourDigits: String? = try container.decodeIfPresent(String.self, forKey: .lastFourDigits)
        let installments: Int? = try container.decodeIfPresent(Int.self, forKey: .installments)

        self.init(cardId: cardId, cardDescription: cardDescription, issuer: issuer, lastFourDigits: lastFourDigits, installments: installments, payerCosts: payerCosts)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PXOneTapCardKeys.self)
        try container.encodeIfPresent(self.issuer, forKey: .issuer)
        try container.encodeIfPresent(self.payerCosts, forKey: .payerCosts)
        try container.encodeIfPresent(self.cardDescription, forKey: .cardDescription)
        try container.encodeIfPresent(self.cardId, forKey: .cardId)
        try container.encodeIfPresent(self.lastFourDigits, forKey: .lastFourDigits)
        try container.encodeIfPresent(self.lastFourDigits, forKey: .installments)
    }

    open func toJSONString() throws -> String? {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return String(data: data, encoding: .utf8)
    }

    open func toJSON() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }

    open class func fromJSONToPXOneTapCard(data: Data) throws -> PXOneTapCard {
        return try JSONDecoder().decode(PXOneTapCard.self, from: data)
    }

    open class func fromJSON(data: Data) throws -> PXOneTapCard {
        return try JSONDecoder().decode(PXOneTapCard.self, from: data)
    }

}
