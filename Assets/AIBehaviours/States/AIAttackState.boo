import UnityEngine


[System.Serializable]
class AIAttackState(AIState): 
    public attackPattern as AttackPattern = StraightAttackPattern() // MAKE THIS FIELD IN EDITOR

    private unit as Unit

    protected override def Init(fsm as AIBehaviours):
        Debug.Log("Attack state called")
        attackPattern.Start(unit)

    protected override def Reason(fsm as AIBehaviours):
        return true

    protected override def Action(fsm as AIBehaviours):
        // Get the unit
        unit = fsm.gameObject.GetComponent(typeof(Unit))
        // Execute attack pattern
        #Debug.Log(attackPattern)
        if attackPattern: 
            attackPattern.Update(unit)
        #Debug.Log("Attacking: " + _ship.target.transform.position  +  fsm.gameObject.transform.position)

        // Rotate around target
        #fsm.gameObject.transform.RotateAround(_ship.target.transform.position, Vector3.up, 10 * Time.deltaTime)
        #scriptWithAttackMethod.SendMessage(methodName, new AIBehaviors_AttackData(attackDamage))
        #_unit.baseProperties.attackPattern.Update()

        #_unit = fsm.gameObject.GetComponent(typeof(Ship))

        // Shoot
        #if _ship.weapons:   // Check if have a weapon system
            #_ship.weapons.Shoot()

    protected override def StateEnded(fsm as AIBehaviours):
        pass

    /*
    def OnTriggerEnter(other as Collider):
        print("collision")
        Debug.Log("collision")
        #_ship.behaviours.ChangeState(_ship.behaviours.behaviourOnIdle)
        #Destroy(other.gameObject)
    */


