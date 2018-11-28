


import UIKit
import VGPlayer
import SnapKit

extension Notification.Name {
    
    static let videoPause = Notification.Name("videoPause")
}

class VGVerticalViewController: UIViewController {
    var player : VGPlayer?
    var stringServer:String?
    
    @IBOutlet weak var backView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.isHidden = true
        let url = URL(string: stringServer!)
        print(url)
      // let url = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        if url != nil {
            player = VGPlayer(URL: url!)
        }
        player?.delegate = self
        view.addSubview((player?.displayView)!)
        player?.backgroundMode = .proceed
        player?.play()
        player?.displayView.delegate = self
        player?.displayView.titleLabel.text = ""
        player?.displayView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.edges.equalTo(strongSelf.view)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoPause), name: .videoPause, object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(videoPause), name: .videoPause, object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        self.player?.displayView.frame = self.view.frame
        self.player?.displayView.addSubview(backView)
        
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
       // UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.player?.pause()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        //UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.default, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AppUtility.lockOrientation(.portrait)
      //  UIApplication.shared.setStatusBarHidden(false, with: .none)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func videoPause() {
        self.player?.pause()
    }
}

extension VGVerticalViewController: VGPlayerDelegate {
    func vgPlayer(_ player: VGPlayer, playerFailed error: VGPlayerError) {
        print(error)
    }
    func vgPlayer(_ player: VGPlayer, stateDidChange state: VGPlayerState) {
        print("player State ",state)
    }
    func vgPlayer(_ player: VGPlayer, bufferStateDidChange state: VGPlayerBufferstate) {
        print("buffer State", state)
    }
}


extension VGVerticalViewController: VGPlayerViewDelegate {
    func vgPlayerView(_ playerView: VGPlayerView, willFullscreen fullscreen: Bool) {
        
    }
    func vgPlayerView(didTappedClose playerView: VGPlayerView) {
        if playerView.isFullScreen {
            playerView.exitFullscreen()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    func vgPlayerView(didDisplayControl playerView: VGPlayerView) {
        UIApplication.shared.setStatusBarHidden(!playerView.isDisplayControl, with: .fade)
    }
    
    
    
    func vgPlayerView(didTapFullScreen fullScreen: Bool) {

        if fullScreen == true {
            AppUtility.lockOrientation(.landscapeRight)
            backView.isHidden = true
        }else{
            AppUtility.lockOrientation(.portrait)
            backView.isHidden = false
        }
    }
    
    @IBAction func btnBackTapped(_ sender:UIButton){
        self.popVC()
    }
}
struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    // OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
}
extension UIViewController {
    
    
    public func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }
}
