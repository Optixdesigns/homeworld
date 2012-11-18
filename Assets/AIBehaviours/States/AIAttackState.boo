import UnityEngine


[System.Serializable]
class AIAttackState(AIState): 
    #private _ship as Ship

    protected override def Init(fsm as AIBehaviours):
        Debug.Log("Attack state called")
        #pass

    protected override def Reason(fsm as AIBehaviours):
        return true

    protected override def Action(fsm as AIBehaviours):
        Debug.Log("Attacking")
        _ship = fsm.gameObject.GetComponent(typeof(Ship))
        #moveToPosition = ship.moveToPosition + ship.damageAttribute.range // Stay at perfect damage range
        moveDir as Vector3 = (_ship.moveToPosition - _ship.gameObject.transform.position)
        #print(_ship.moveToPosition)
        #print(_ship.gameObject.transform.position)
        
        // Rotate towards the waypoint
        _ship.gameObject.transform.rotation = Quaternion.Slerp(_ship.gameObject.transform.rotation, Quaternion.LookRotation(moveDir), (_ship.baseProperties.maxRotate * Time.deltaTime))
        _ship.gameObject.transform.eulerAngles = Vector3(0, _ship.gameObject.transform.eulerAngles.y, 0)
        
        // Calculate velocity
        velocity = (moveDir.normalized * _ship.baseProperties.maxVelocity)
        
        // Apply the new Velocity
        _ship.gameObject.rigidbody.velocity = velocity

        # CHECK IF SOMETHING IS IN THE WAY OR ARRIVED
        #if _ship.moveToPosition == _ship.gameObject.transform.position: // arrived
            #_ship.behaviours.ChangeState(_ship.behaviours.behaviourOnIdle) 

    def OnTriggerEnter(other as Collider):
        print("collision")
        Debug.Log("collision")
        #_ship.behaviours.ChangeState(_ship.behaviours.behaviourOnIdle)
        #Destroy(other.gameObject)


