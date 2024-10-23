//
//  Icon.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 19/04/1446 AH.
//
import UIKit

struct Icon {
    var index: Int
    var categories: InterestCategories
    var icons: (UIImage, UIColor) {
        switch categories {
        case .All:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        case .Arts:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        case .Cultural:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        case .Environmental:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        case .Financial:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        case .Healthy:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        case .Social:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        case .Sports:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        case .Technical:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        case .Tourism:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2630000114, green: 0.8080000281, blue: 0.7689999938, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)][index])
        }
    }
    
}
