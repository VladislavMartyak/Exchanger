import UIKit

extension UIView {
    
    class func loadViewFromNib<T>(owner: Any? = nil) -> T? where T: UIView {
        
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        let view = nib.instantiate(withOwner: owner, options: nil).first as? T
        
        return view
    }
}
