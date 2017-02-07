class BanditQuest:Quest{
    
    override init() {
        super.init()
        objectives.append(Objective(description: "Kill the bandit leader", toKill: BanditLeader(), numToKill: 1))
    }
}
