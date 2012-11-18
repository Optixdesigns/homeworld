import UnityEngine

[System.Serializable]
class AIMoveState(AIState): 
    private _ship as Ship

    protected override def StateEnded(fsm as AIBehaviours):
        pass

    protected override def Action(fsm as AIBehaviours):
        pass
        /*
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
        if _ship.moveToPosition == _ship.gameObject.transform.position: // arrived
            _ship.behaviours.ChangeState(_ship.behaviours.behaviourOnIdle)
        */    
