

import UIKit

class SideMenuTableViewCell: UITableViewCell
{
    @IBOutlet weak var imgSideMenuIcon: UIImageView!
    @IBOutlet weak var lblTitle: BaseUILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
    
    open class func height() -> CGFloat
    {
        return DesignUtility.getValueFromRatio(45)
    }
    
    



    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        if selected
        {
            let selectedView:UIView = UIView()
            selectedView.backgroundColor = Color.appDarkPink
            self.selectedBackgroundView? = selectedView
//            lblTitle.textColor = UIColor.init(hexString: "#C89F68")
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool)
    {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted
        {
            let selectedView:UIView = UIView()
            selectedView.backgroundColor = Color.appDarkPink
            self.selectedBackgroundView? = selectedView
//            lblTitle.textColor = UIColor.init(hexString: "#C89F68")
        }
    }
    
} // end class SideMenuTableViewCell


