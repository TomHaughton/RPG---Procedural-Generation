class BanditQuest:Quest{
    
    override init() {
        super.init()
        reward = TestBow()
        objectives.append(Objective(description: "Kill the bandit leader", toKill: BanditLeader(), numToKill: 1))
    }
}
