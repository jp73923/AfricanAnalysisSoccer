//
//  MatchVC.swift
//  AfricanAnalysisSoccer
//
//  Created by VinMac on 29/06/22.
//

import UIKit
import SwiftyJSON
import SDWebImage

class MatchVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var vwUpcoming: UIView!
    @IBOutlet weak var vwPast: UIView!
    
    @IBOutlet weak var tblMatch: UITableView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPastLine: UILabel!
    @IBOutlet weak var lblUpcomingLine: UILabel!
    @IBOutlet weak var lblUpcoming: UILabel!
    @IBOutlet weak var lblPast: UILabel!
    
    @IBOutlet weak var lblNoData: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnUpcoming: UIButton!
    @IBOutlet weak var btnPast: UIButton!
    
    //MARK: - Constants
    var arrLeague:[ClassLeague] = [ClassLeague]()
    var objLeague:ClassLeague?
    var page = 1
    
    //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.api_getLeagueGame()
    }
    
    //MARK: - Button Action Methods
    @IBAction func btnBack_clicked(_ sender: UIButton) {
        APP_DELEGATE.appNavigation?.popViewController(animated: true)
    }
    
    @IBAction func btnEvents_clicked(_ sender: UIButton) {
        self.arrLeague.removeAll()
        self.tblMatch.reloadData()
        if sender.tag == 10 {
            self.vwUpcoming.backgroundColor = Color_Hex(hex: "#D9D9D9").withAlphaComponent(0.5)
            self.vwPast.backgroundColor = .white
            self.lblUpcomingLine.backgroundColor = Color_Hex(hex: "00825C")
            self.lblPastLine.backgroundColor = .white
            self.lblTitle.text = "Upcoming events"
            self.api_getLeagueGame()
        } else {
            self.vwUpcoming.backgroundColor = .white
            self.vwPast.backgroundColor = Color_Hex(hex: "#D9D9D9").withAlphaComponent(0.5)
            self.lblUpcomingLine.backgroundColor = .white
            self.lblPastLine.backgroundColor = Color_Hex(hex: "00825C")
            self.lblTitle.text = "Past events"
            self.api_getLeagueGame(isFromPast: true)
        }
    }
    
}

//MARK: - UITableView Delegate & Datasource Methods
extension MatchVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.lblNoData.isHidden = self.arrLeague.count > 0 ? true : false
        return self.arrLeague.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblMatch.dequeueReusableCell(withIdentifier: "LeagueDetailsCell") as! LeagueDetailsCell
        cell.tag = indexPath.row
        cell.setUpDetails(obj: self.arrLeague[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idAnalysisVC) as! AnalaysisVC
        vc.objLeague = self.arrLeague[indexPath.row]
        APP_DELEGATE.appNavigation?.pushViewController(vc, animated: true)
    }
}

//MARK: - API Calling Methods
extension MatchVC {
    func api_getLeagueGame(isFromPast:Bool = false) {
        var url = URL_Domain + "task=livedata&league=\(self.objLeague?.league?.id ?? "")"
        if isFromPast {
            url = URL_Domain + "task=enddata&league=\(self.objLeague?.league?.id ?? "")"
        }
        HttpRequestManager.shared.getRequest(
            requestURL:url,
            param:[:],
            showLoader:true)
        {(error,responseDict) -> Void in
            if error != nil {
                showMessageWithRetry(RetryMessage,3, buttonTapHandler: { _ in self.api_getLeagueGame()
                })
                return
            } else if let dicData = responseDict, dicData.keys.count > 0 {
                print(dicData)
                if isFromPast {
                    if let arrLeague = dicData["games_end"] as? NSArray, arrLeague.count > 0 {
                        var arr:[ClassLeague] = []
                        for obj in arrLeague {
                            arr.append(ClassLeague.init(json: JSON(obj)))
                        }
                        self.arrLeague = arr.filter({$0.league?.id == self.objLeague?.league?.id})
                    }
                } else {
                    if let arrLeague = dicData["games_live"] as? NSArray, arrLeague.count > 0 {
                        var arr:[ClassLeague] = []
                        for obj in arrLeague {
                            arr.append(ClassLeague.init(json: JSON(obj)))
                        }
                        self.arrLeague = arr.filter({$0.league?.id == self.objLeague?.league?.id})
                    }
                }
                self.tblMatch.reloadData()
            }
        }
    }
}
