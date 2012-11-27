import UnityEngine

class MovementModule(MonoBehaviour): 
    public maxVelocity as single = 5.0              // // maximum velocity
    public accelerationSpeed as single = 2.0        // Acceleration speed
    public turningSpeed as single = 3.0            // maximum rotate speed
    public turningSnappyness as single = 3.0
    public bankingAmount as single = 1.0
    public centerOfMass as Transform
    
    private unit as Unit
    [HideInInspector]
    public moveDirection as Vector3 // The direction the character wants to move in, in world space.
    [HideInInspector]
    public facingDirection as Vector3
    #private move as bool = false
    #private targetAngle

    def Start():
        unit = gameObject.GetComponent(typeof(Unit))

        moveDirection = Vector3.zero
        facingDirection = Vector3.zero

        // Setup center of mass
        if centerOfMass != null:
            rigidbody.centerOfMass = centerOfMass.localPosition
    
    #def FixedUpdate():
        #if move:
            #Move()
    
    #def MoveTo(v as Vector3):
        #MoveToPosition = v
        #move = true

    def MoveToWaypoint():
        pass
    
    def Stop():
        moveDirection = Vector3.zero
        rigidbody.velocity = Vector3(0, 0, 0)
        #gameobject.transform.position = Vector3.MoveTowards(gameObject.transform.position, unit.target.transform.position, unit.baseProperties.maxVelocity / 5)
    
    def FixedUpdate():
        // Handle movement
        #targetVelocity as Vector3 = moveDirection * maxVelocity
        #deltaVelocity as Vector3 = targetVelocity - rigidbody.velocity
        #rigidbody.AddForce(deltaVelocity * accelerationSpeed, ForceMode.Acceleration)

        // Limit velocity to maxspeed
        #rigidbody.velocity = Vector3.ClampMagnitude(rigidbody.velocity, maxVelocity)
        #Debug.Log(moveDirection)
        if moveDirection != Vector3.zero:
            // Add force to move
            rigidbody.AddRelativeForce(Vector3.forward * accelerationSpeed * Time.deltaTime)
            // Limit velocity to maxspeed
            rigidbody.velocity = Vector3.ClampMagnitude(rigidbody.velocity, maxVelocity)

        // Rotate unit
 
        facingDir as Vector3
        if facingDirection != Vector3.zero:
            facingDir = facingDirection
        else:
            facingDir = moveDirection

        if facingDir != Vector3.zero:
            rotation = Quaternion.LookRotation(facingDir - transform.position)
            transform.rotation = Quaternion.Slerp(transform.rotation, rotation, Time.deltaTime * turningSpeed)

        // Rotate unit
        /*
        facingDir as Vector3
        if facingDirection != Vector3.zero:
            facingDir = facingDirection
        else:
            facingDir = moveDirection

        if facingDir != Vector3.zero:
            targetRotation = Quaternion.LookRotation(facingDir, Vector3.up)
            deltaRotation = targetRotation * Quaternion.Inverse(transform.rotation)
            axis as Vector3
            angle as single
            deltaRotation.ToAngleAxis(angle, axis)
            deltaAngularVelocity as Vector3 = axis * Mathf.Clamp (angle, -turningSpeed, turningSpeed) - rigidbody.angularVelocity
            
            banking as single = Vector3.Dot(moveDirection, -transform.right)
            
            rigidbody.AddTorque(deltaAngularVelocity * turningSnappyness + transform.forward * banking * bankingAmount)
        */    

    /*
    def FixedUpdate():
        if MoveToPosition is not Vector3.zero:
            // Rotate in the right direction
            rotation = Quaternion.LookRotation(MoveToPosition - transform.position)
            transform.rotation = Quaternion.Slerp(transform.rotation, rotation, Time.deltaTime * rotationSpeed)

            // Add force to move
            rigidbody.AddRelativeForce(Vector3.forward * accelerationSpeed * Time.deltaTime)
            // Limit velocity to maxspeed
            rigidbody.velocity = Vector3.ClampMagnitude(rigidbody.velocity, maxVelocity)

            // Stop when we are there
            distance = Vector3.Distance(MoveToPosition, transform.position)
            #if distance <= 5:
                #Stop()
    */
