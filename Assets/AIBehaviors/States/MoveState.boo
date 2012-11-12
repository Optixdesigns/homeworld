import UnityEngine

[System.Serializable]
class MoveState(AIState): 
    private _ship as Ship

    def Start():
        ship = transform.parent.gameObject.GetComponent[of Ship]()
    
    def Update():
        ship = transform.parent.gameObject.GetComponent[of Ship]()

        #moveToPosition = ship.moveToPosition + ship.damageAttribute.range // Stay at perfect damage range
        moveDir as Vector3 = (ship.moveToPosition - ship.gameObject.transform.position) 
        
        // Rotate towards the waypoint
        ship.gameObject.transform.rotation = Quaternion.Slerp(ship.gameObject.transform.rotation, Quaternion.LookRotation(moveDir), (ship.baseProperties.maxRotate * Time.deltaTime))
        ship.gameObject.transform.eulerAngles = Vector3(0, ship.gameObject.transform.eulerAngles.y, 0)
        
        // Calculate velocity
        velocity = (moveDir.normalized * ship.baseProperties.maxVelocity)
        
        // Apply the new Velocity
        ship.gameObject.rigidbody.velocity = velocity

        # CHECK IF SOMETHING IS IN THE WAY

    def OnCollisionEnter(collision as Collision):
        _ship.behaviours.ChangeState(_ship.behaviours.behaviourOnIdle)


