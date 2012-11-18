import UnityEngine


[System.Serializable]
class AIAttackState(AIState): 

    protected override def Init(fsm as AIBehaviours):
        Debug.Log("Attack state called")

    protected override def Reason(fsm as AIBehaviours):
        return true

    protected override def Action(fsm as AIBehaviours):
        _ship = fsm.gameObject.GetComponent(typeof(Ship))
        #Debug.Log("Attacking: " + _ship.target.transform.position  +  fsm.gameObject.transform.position)

        fsm.gameObject.transform.RotateAround(_ship.target.transform.position, Vector3.up, 10 * Time.deltaTime)

    def OnTriggerEnter(other as Collider):
        print("collision")
        Debug.Log("collision")
        #_ship.behaviours.ChangeState(_ship.behaviours.behaviourOnIdle)
        #Destroy(other.gameObject)


