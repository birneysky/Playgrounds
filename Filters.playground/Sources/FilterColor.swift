import UIKit

extension UIColor {
    public static var randomColor: UIColor? {
        var color: UIColor?  = nil
        switch arc4random() % 5 {
        case 0:
            color = .green
        case 1:
            color = .blue
        case 2:
            color = .orange
        case 3:
            color = .red
        case 4:
            color = .gray
        default:
            color = .purple
        }
        return color
    }
}
