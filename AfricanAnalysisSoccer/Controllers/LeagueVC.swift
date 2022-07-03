//
//  LeagueVC.swift
//  AfricanAnalysisSoccer
//
//  Created by VinMac on 28/06/22.
//

import UIKit
import SwiftyJSON
import SDWebImage

class LeagueVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tblLeague: UITableView!
    
    @IBOutlet weak var lblNoData: UILabel!
    
    //MARK: - Constants
    var arrLeague:[ClassLeague] = [ClassLeague]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.api_getLiveGames()
    }
    
}

//MARK: - UITableView Delegate & Datasource Methods
extension LeagueVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.lblNoData.isHidden = self.arrLeague.count > 0 ? true : false
        return self.arrLeague.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.arrLeague[indexPath.row]
        let cell = self.tblLeague.dequeueReusableCell(withIdentifier: "LeagueCell") as! LeagueCell
        cell.imgLeague.sd_setImage(with: URL(string: "https://spoyer.com/api/team_img/soccer/\(obj.home?.imageId ?? "")"), placeholderImage: UIImage(named: "ic_football_placeholder"), options: [], completed: nil)
        cell.lblCount.text = "\(indexPath.row + 1)"
        cell.lblLeagueName.text = obj.league?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idMatcheVC) as! MatchVC
        vc.objLeague = self.arrLeague[indexPath.row]
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
}

//MARK: - API Calling Methods
extension LeagueVC {
    func api_getLiveGames() {
        HttpRequestManager.shared.getRequest(
            requestURL:API_LiveData,
            param:[:],
            showLoader:true)
        {(error,responseDict) -> Void in
            if error != nil {
                showMessageWithRetry(RetryMessage,3, buttonTapHandler: { _ in self.api_getLiveGames()
                })
                return
            } else if let dicData = responseDict, dicData.keys.count > 0 {
                self.arrLeague.removeAll()
                if let arrLeague = dicData["games_live"] as? NSArray, arrLeague.count > 0 {
                    for obj in arrLeague {
                        let objLeague = ClassLeague.init(json: JSON(obj))
                        if !(self.arrLeague.contains(objLeague)) {
                            self.arrLeague.append(objLeague)
                        }
                    }
                }
                self.tblLeague.reloadData()
            }
        }
    }
}
