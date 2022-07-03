//
//  LeagueDetailsCell.swift
//  YoungSportEvent
//
//  Created by VinMac on 30/05/22.
//

import UIKit

class LeagueDetailsCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var imgTeamOne: UIImageView!
    @IBOutlet weak var imgTeamTwo: UIImageView!
    
    @IBOutlet weak var lblTeamOne: UILabel!
    @IBOutlet weak var lblTeamTwo: UILabel!
    @IBOutlet weak var lblTimeOne: UILabel!
    @IBOutlet weak var lblTimeTwo: UILabel!
    
    //MARK: - Custom Methods
    func setUpDetails(obj:ClassLeague) {
        self.imgTeamOne.sd_setImage(with: URL(string: "https://spoyer.com/api/team_img/soccer/\(obj.home?.imageId ?? "")"), placeholderImage: UIImage(named: "ic_football_placeholder"), options: [], completed: nil)
        self.imgTeamTwo.sd_setImage(with: URL(string: "https://spoyer.com/api/team_img/soccer/\(obj.away?.imageId ?? "")"), placeholderImage: UIImage(named: "ic_football_placeholder"), options: [], completed: nil)
        self.lblTeamOne.text = obj.home?.name
        self.lblTeamTwo.text = obj.away?.name
        self.lblTimeOne.text = obj.score
        self.lblTimeTwo.text = obj.timer
    }
    
}
