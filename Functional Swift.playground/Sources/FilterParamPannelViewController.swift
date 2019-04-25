import UIKit

class FilterParamPannelViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height / 2)
        print(self)
    }
}
