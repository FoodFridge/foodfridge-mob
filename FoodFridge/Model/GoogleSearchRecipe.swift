//
//  GoogleSearchRecipe.swift
//  FoodFridge
//
//  Created by Jessie Pastan on 1/26/24.
//

import Foundation
struct GoogleSearchRecipe: Codable, Hashable,Identifiable {
    let id: Int
    let title: String
    let link: String
    let img: String
   
}

extension GoogleSearchRecipe {
    static var mockGoogleSearchRecipes : [GoogleSearchRecipe] {
        [ GoogleSearchRecipe(id: 1, title:"Soy Ginger Salmon {Fast, Healthy Asian Salmon Recipe ...", link: "https://www.wellplated.com/soy-ginger-salmon/", img: "https://www.wellplated.com/wp-content/uploads/2017/04/Baked-Soy-Ginger-Salmon.jpg"),
          GoogleSearchRecipe(id: 2, title:"Fast Salmon with a Ginger Glaze", link: "https://www.allrecipes.com/recipe/221267/fast-salmon-with-a-ginger-glaze/", img: "https://www.allrecipes.com/thmb/XTXoOKz6peniiBnM2kkirJuuU88=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/3454021-beecf248feb848fcb823e5e73406089e.jpg"),
          GoogleSearchRecipe(id: 3, title:"Honey Garlic Soy Glazed Salmon - Sally's Baking Addiction" ,link: "https://sallysbakingaddiction.com/honey-garlic-salmon/", img: "https://sallysbakingaddiction.com/wp-content/uploads/2015/06/honey-garlic-soy-glazed-salmon.jpg"),
          GoogleSearchRecipe(id: 4, title: "Ginger-Glazed Salmon Recipe | Molly Yeh | Food Network" ,link: "https://www.foodnetwork.com/recipes/ginger-glazed-salmon-5543612",  img: "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2018/12/20/0/MW0211_Ginger-Glazed-Salmon_s4x3.jpg.rend.hgtvcom.616.462.suffix/1545325997083.jpeg"),
          GoogleSearchRecipe(id: 5, title: "Ginger Glazed Salmon Bites (Air Fryer) - Tiffy Cooks", link: "https://tiffycooks.com/ginger-glazed-salmon-bites-air-fryer/", img: "https://tiffycooks.com/wp-content/uploads/2022/08/DD994E2C-4545-4C86-8708-A2CD3FA0167D-scaled.jpg"),
          GoogleSearchRecipe(id: 6, title: "Honey Ginger Glazed Salmon | Lindsey Eats", link: "https://lindseyeatsla.com/honey-ginger-glazed-salmon/", img: "https://lindseyeatsla.com/wp-content/uploads/2023/07/Lindseyeats_Honey_Ginger_Glazed_Salmon-4.jpg"),
          GoogleSearchRecipe(id: 7, title: "Baked Asian Salmon with Honey Ginger Glaze - Lemon Blossoms",link: "https://www.lemonblossoms.com/blog/honey-ginger-salmon-dinner-in-20-minutes/", img: "https://www.lemonblossoms.com/wp-content/uploads/2016/10/Oven-Baked-Salmon-with-Honey-Ginger-S3.jpg"),
          GoogleSearchRecipe(id: 8, title: "Baked Ginger Salmon - Budget Bytes", link: "https://www.budgetbytes.com/ginger-salmon/", img: "https://www.budgetbytes.com/wp-content/uploads/2011/04/Baked-Ginger-Salmon-flaked.jpg"),
          GoogleSearchRecipe(id: 9, title: "Honey Ginger Glazed Salmon Recipe | Elizabeth Rider", link: "https://www.elizabethrider.com/ginger-honey-glazed-salmon-recipe/", img: "https://www.elizabethrider.com/wp-content/uploads/2022/04/honey-glaze-salmon-recipe-copyrightelizabethrider.jpg"),
          GoogleSearchRecipe(id: 10, title: "Soy Ginger Salmon Recipe", link: "https://www.foodandwine.com/recipes/pan-roasted-salmon-with-soy-ginger-glaze", img: "https://www.foodandwine.com/thmb/1YOw_1ajIWmLXNx8XNct69xxLlg=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/fw200501_070salmon-66d93352b11f4a6daf404885f267d3bc.jpg"),
        ]
        
    }
    
}
