


class TestAttackPattern(AttackPattern):
    private attackMaxDistance = 25 /// Distance needed to start a attack run
    private attackMinDistance = 10 /// Distance to target wich ends a run
    private isInAttackDistance = false
    
    def Update():
        dist as single = GetDistance(unit.target.transform.position, unit.transform.position)
        if dist < attackMaxDistance and dist > attackMinDistance:
            isInAttackDistance = true
        else:
            isInAttackDistance = false    
        
        if not isInAttackDistance:
            iTween.LookTo(unit.gameObject, unit.target.transform.position, 5)
            iTween.MoveTo(unit.gameObject, unit.target.transform.position, 5)
            #iTween.MoveBy(unit.gameObject, iTween.Hash("x", 2, "easeType", "easeInOutExpo", "loopType", "pingPong", "delay", .1))
            #iTween.MoveTo(unit.gameObject, iTween.Hash("x", 2, "easeType", "easeInOutExpo", "loopType", "pingPong", "delay", .1))
        else:
            iTween.Stop(unit.gameObject)


