//
//  DefaultConfig.swift


import UIKit

public let DEFAULT_CONFIG = DefaultConfig.shared;

public class DefaultConfig: NSObject {
    
    static let shared = DefaultConfig()
    
    //Project settings
    public var baseUrl:String = "https://thebrandszone.com/zaha-app/api/";
    public var baseUrlImage:String = "http://laundry.stagingic.com/api/resize/";

    public var defaultFontName:String = "fontDefault";
    public var defaultFontSize:String = "sizeMedium";
    public var defaultFontColor:String = "theme";
    
    public var defaultButtonFontColor = "themeButton";
    public var defaultButtonSelectedFontColor = "themeSelectedButton";

    public var defaultButtonImageSpacing:CGFloat = 5;
    
    public var defaultShadowRadius:CGFloat = 2;
    public var defaultShadowOpacity:CGFloat = 0.3;
    
    //PRIVATE init so that singleton class should not be reinitialized from anyother class
    fileprivate override init() {
        super.init()
    }
}
