import UnityEngine

class ShipMoveController(MonoBehaviour): 

    def Start():
        pass
    
    def Update():
        ship = transform.parent.gameObject
        __shipController = ship.gameObject.GetComponent[of Ship]() 
        __shipProperties = ship.gameObject.GetComponent[of ShipProperties]()

        moveDir as Vector3 = (__shipController.target.transform.position - ship.gameObject.transform.position)     
        #velocity as Vector3 = controller.gameObject.rigidbody.velocity
        
        // Rotate towards the waypoint
        gameObject.transform.rotation = Quaternion.Slerp(gameObject.transform.rotation, Quaternion.LookRotation(moveDir), (__shipProperties.maxRotate * Time.deltaTime))
        gameObject.transform.eulerAngles = Vector3(0, gameObject.transform.eulerAngles.y, 0)
        
        // Calculate velocity
        velocity = (moveDir.normalized * __shipProperties.maxVelocity)
        
        // Apply the new Velocity
        gameObject.rigidbody.velocity = velocity