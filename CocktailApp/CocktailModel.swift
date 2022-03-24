//
//  CocktailModel.swift
//  CocktailApp
//
//  Created by Andrea Gualandris on 24/03/2022.
//

import UIKit

// recreate the same model structure as the json we get from the API in order to convert id perfectly with Codable protocol
struct Cocktail: Codable{
    let ingredients: [Ingredient]?
}

struct Ingredient: Codable {
    let idIngredient: String?
    let strIngredient: String?
    let strDescription: String?
    let strType: String?
    let strAlcohol: String?
    let strABV: String?
}

