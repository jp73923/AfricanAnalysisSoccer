//
//  AnalaysisVC.swift
//  AfricanAnalysisSoccer
//
//  Created by VinMac on 01/07/22.
//

import UIKit
import SwiftyJSON
import SDWebImage

class AnalaysisVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tblStatistic: UITableView!
    @IBOutlet weak var lblTeamVS: UILabel!
    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    @IBOutlet weak var lblLeagueName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTimeDate: UILabel!
    @IBOutlet weak var lblScore: UILabel!

    //MARK: - Constants
    var objLeague:ClassLeague?
    var objGame:ClassGameDetails?
    var arrStats:[[String:Any]] = []
    
    //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblLeagueName.text = objLeague?.league?.name
        self.lblTeam1.text = objLeague?.home?.name
        self.lblTeam2.text = objLeague?.away?.name
        self.lblScore.text = objLeague?.score
        self.lblTeamVS.text = (objLeague?.home?.name ?? "") + " vs " + (objLeague?.away?.name ?? "")
        self.lblTimeDate.text = objLeague?.timer
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.api_getGameData()
    }
    
    func getStatitics(obj:Stats) -> [[String:Any]] {
        var arr:[[String:Any]] = []
        
        if (self.objGame?.stats?.ballSafe?.count ?? 0) > 0 {
            arr.append(["name":"ballSafe","scoreone":self.objGame?.stats?.ballSafe?[0]  ?? "","scoretwo":self.objGame?.stats?.ballSafe?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.onTarget?.count ?? 0) > 0 {
            arr.append(["name":"onTarget","scoreone":self.objGame?.stats?.onTarget?[0] ?? "","scoretwo":self.objGame?.stats?.onTarget?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.offTarget?.count ?? 0) > 0 {
            arr.append(["name":"offTarget","scoreone":self.objGame?.stats?.offTarget?[0] ?? "","scoretwo":self.objGame?.stats?.offTarget?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.dangerousAttacks?.count ?? 0) > 0 {
            arr.append(["name":"dangerousAttacks","scoreone":self.objGame?.stats?.dangerousAttacks?[0] ?? "","scoretwo":self.objGame?.stats?.dangerousAttacks?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.substitutions?.count ?? 0) > 0 {
            arr.append(["name":"substitutions","scoreone":self.objGame?.stats?.substitutions?[0] ?? "","scoretwo":self.objGame?.stats?.substitutions?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.goals?.count ?? 0) > 0 {
            arr.append(["name":"goals","scoreone":self.objGame?.stats?.goals?[0] ?? "","scoretwo":self.objGame?.stats?.goals?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.redcards?.count ?? 0) > 0 {
            arr.append(["name":"redcards","scoreone":self.objGame?.stats?.redcards?[0] ?? "","scoretwo":self.objGame?.stats?.redcards?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.yellowredCards?.count ?? 0) > 0 {
            arr.append(["name":"yellowredCards","scoreone":self.objGame?.stats?.yellowredCards?[0] ?? "","scoretwo":self.objGame?.stats?.yellowredCards?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.penalties?.count ?? 0) > 0 {
            arr.append(["name":"penalties","scoreone":self.objGame?.stats?.penalties?[0] ?? "","scoretwo":self.objGame?.stats?.penalties?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.penalties?.count ?? 0) > 0 {
            arr.append(["name":"corners","scoreone":self.objGame?.stats?.corners?[0] ?? "","scoretwo":self.objGame?.stats?.corners?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.penalties?.count ?? 0) > 0 {
            arr.append(["name":"cornerH","scoreone":self.objGame?.stats?.cornerH?[0] ?? "","scoretwo":self.objGame?.stats?.cornerH?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.attacks?.count ?? 0) > 0 {
            arr.append(["name":"attacks","scoreone":self.objGame?.stats?.attacks?[0] ?? "","scoretwo":self.objGame?.stats?.attacks?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.cornerF?.count ?? 0) > 0 {
            arr.append(["name":"cornerF","scoreone":self.objGame?.stats?.cornerF?[0] ?? "","scoretwo":self.objGame?.stats?.cornerF?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.yellowcards?.count ?? 0) > 0 {
            arr.append(["name":"yellowcards","scoreone":self.objGame?.stats?.yellowcards?[0] ?? "","scoretwo":self.objGame?.stats?.yellowcards?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.injuries?.count ?? 0) > 0 {
            arr.append(["name":"yellowcards","scoreone":self.objGame?.stats?.injuries?[0] ?? "","scoretwo":self.objGame?.stats?.injuries?[1] ?? ""])
        }
        
        if (self.objGame?.stats?.possessionRt?.count ?? 0) > 0 {
            arr.append(["name":"possessionRt","scoreone":self.objGame?.stats?.possessionRt?[0] ?? "","scoretwo":self.objGame?.stats?.possessionRt?[1] ?? ""])
        }
        
        return arr
    }
    
    //MARK: - Button Action Methods
    @IBAction func btnBack_clicked(_ sender: UIButton) {
        APP_DELEGATE.appNavigation?.popViewController(animated: true)
    }
    
}

//MARK: - UITableView Delegate & Datasource Methods
extension AnalaysisVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrStats.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblStatistic.dequeueReusableCell(withIdentifier: "StatisticCell") as! StatisticCell
        let obj = self.arrStats[indexPath.row]
        cell.lblTitle.text = obj["name"] as? String ?? ""
        cell.lblPointOne.text = obj["scoreone"] as? String ?? "0"
        cell.lblPointTwo.text = obj["scoretwo"] as? String ?? "0"
        if indexPath.row == self.arrStats.count - 1 {
            cell.lblLine.isHidden = true
        } else {
            cell.lblLine.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

//MARK: - API Calling Methods
extension AnalaysisVC {
    func api_getGameData() {
        print(URL_Domain + "task=eventdata&game_id=\(self.objLeague?.gameId ?? "")")
        HttpRequestManager.shared.getRequest(
            requestURL:URL_Domain + "task=eventdata&game_id=\(self.objLeague?.gameId ?? "")",
            param:[:],
            showLoader:true)
        {(error,responseDict) -> Void in
            if error != nil {
                showMessageWithRetry(RetryMessage,3, buttonTapHandler: { _ in self.api_getGameData()
                })
                return
            } else if let dicData = responseDict, dicData.keys.count > 0 {
                print(dicData)
                if let arrLeague = dicData["results"] as? NSArray, arrLeague.count > 0 {
                   self.objGame = ClassGameDetails.init(json: JSON(arrLeague[0]))
                }
                
                if let obj = self.objGame?.stats {
                    self.arrStats = self.getStatitics(obj: obj)
                }
                
                self.tblStatistic.reloadData()
            }
        }
    }
}
