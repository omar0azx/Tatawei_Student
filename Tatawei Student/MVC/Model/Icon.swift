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
        case .Arts:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        case .Cultural:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        case .Environmental:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        case .Financial:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        case .Healthy:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        case .Social:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        case .Sports:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        case .Technical:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        case .Tourism:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        case .religious:
            return ([#imageLiteral(resourceName: "beach.svg"), #imageLiteral(resourceName: "kaaba.svg"), #imageLiteral(resourceName: "iftar.svg"), #imageLiteral(resourceName: "iftar.svg")][index], [#colorLiteral(red: 0.968627451, green: 0.7294117647, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.8705882353, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.8745098039, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.968627451, blue: 0.6823529412, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.968627451, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.9450980392, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.7764705882, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.6823529412, blue: 0.968627451, alpha: 1), #colorLiteral(red: 0.968627451, green: 0.6823529412, blue: 0.7843137255, alpha: 1)][index])
        default:
            print("All")
            return (#imageLiteral(resourceName: "iftar.svg"), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        }
    }
    
}
