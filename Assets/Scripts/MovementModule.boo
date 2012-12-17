import UnityEngine

# TODO CALCULATE ANGULAR DRAG, STABILITY AND STABILITY SPEED
class MovementModule(MonoBehaviour): 
    public maxVelocity as single = 5.0              // // maximum velocity
    public accelerationSpeed as single = 2.0        // Acceleration speed
    private turningSpeed as single = 3.0            // maximum rotate speed
    public turningSnappyness as single = 3.0
    public bankingAmount as single = 1.0
    
    public engine as GameObject

    private unit as Unit
    [HideInInspector]
    public moveDirection as Vector3 // The direction the character wants to move in, in world space.
    [HideInInspector]
    public facingDirection as Vector3  // The direction to face

    private mass as single // Mass in tons
    private thrust as single // current engine thrust

    private ax as single = 0
    private ay as single = 0


    def Awake():
        // Setup some stuff
        unit = gameObject.GetComponent(typeof(Unit))

        turningSpeed = 1 / rigidbody.mass
        mass = unit.mass
        moveDirection = Vector3.zero
        facingDirection = Vector3.zero

    def SetWaypoint():
        pass
    
    #def Stop():
        #moveDirection = Vector3.zero
        #rigidbody.velocity = Vector3(0, 0, 0)
    def Update():
        pass
        #if engine:
            #engine.particleEmitter.worldVelocity = rigidbody.velocity

    private def Move():
        // Add speed
        rigidbody.AddRelativeForce(Vector3.forward * accelerationSpeed * Time.deltaTime)
        // Limit velocity to maximum
        rigidbody.velocity = Vector3.ClampMagnitude(rigidbody.velocity, maxVelocity)

    private def RotateTo(p as Vector3):

        #transform.LookAt(p)
        force = 1
        #Debug.Log(p)
        targetDelta as Vector3 = p - transform.position
 
        //get the angle between transform.forward and target delta
        angleDiff as single = Vector3.Angle(transform.forward, targetDelta)
 
        // get its cross product, which is the axis of rotation to
        // get from one vector to the other
        cross as Vector3 = Vector3.Cross(transform.forward, targetDelta)
 
        // apply torque along that axis according to the magnitude of the angle.
        rigidbody.AddTorque(cross * angleDiff * force)

    
        stability = 0.3
        speed = 2.0

        // Stabilze to z axis
        predictedUp as Vector3 = Quaternion.AngleAxis(
            rigidbody.angularVelocity.magnitude * Mathf.Rad2Deg * stability / speed,
            rigidbody.angularVelocity
        ) * transform.up
 
        torqueVector as Vector3 = Vector3.Cross(predictedUp, Vector3.up)
        // Uncomment the next line to stabilize on only 1 axis.
        torqueVector = Vector3.Project(torqueVector, transform.forward)
        rigidbody.AddTorque(torqueVector * speed)


    def FixedUpdate():

        facingDir as Vector3 = Vector3.zero

        if facingDirection != Vector3.zero:
            facingDir = facingDirection
        else:
            facingDir = moveDirection
        
        if facingDir != Vector3.zero:
            #Debug.Log("Rotating")
            RotateTo(facingDir)
        else:
            pass
            # straighten out on z axis

        if moveDirection != Vector3.zero:
            Move()
        else: // No movement, straithen out
            pass
            # on the z axis 

       


