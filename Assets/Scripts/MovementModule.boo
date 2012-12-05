import UnityEngine

class MovementModule(MonoBehaviour): 
    public maxVelocity as single = 5.0              // // maximum velocity
    public accelerationSpeed as single = 2.0        // Acceleration speed
    private turningSpeed as single = 3.0            // maximum rotate speed
    public turningSnappyness as single = 3.0
    public bankingAmount as single = 1.0
    
    private unit as Unit
    [HideInInspector]
    public moveDirection as Vector3 // The direction the character wants to move in, in world space.
    [HideInInspector]
    public facingDirection as Vector3   // The direction to face

    private mass as single // Mass in tons
    private thrust as single // current engine thrust

    private ax as single = 0
    private ay as single = 0



    def Start():
        // Setup some stuff
        unit = gameObject.GetComponent(typeof(Unit))

        // Needed vars
        moveDirection = Vector3.zero
        facingDirection = Vector3.zero
        turningSpeed = 1 / rigidbody.mass
        mass = unit.mass

    def SetWaypoint():
        pass
    
    def Stop():
        moveDirection = Vector3.zero
        rigidbody.velocity = Vector3(0, 0, 0)

    private def Move():
        // Add speed
        rigidbody.AddRelativeForce(Vector3.forward * accelerationSpeed * Time.deltaTime)
        #thrust += accelerationSpeed * Time.deltaTime
        // Limit velocity to maxspeed
        rigidbody.velocity = Vector3.ClampMagnitude(rigidbody.velocity, maxVelocity)

    private def RotateTo(p as Vector3):
        #maxang = 90
        #rotX = Mathf.Abs(Mathf.Abs(transform.position.y-targetH)/maxDist) * (transform.position.y > targetH ? -1 : 1) * -maxAng
        #angle = Vector3.Angle(transform.position, facingDirection)
        #Debug.Log(angle)
        #eulerAngleVelocity as Vector3 = Vector3(0, 100, 0)
        #deltaRotation as Quaternion = Quaternion.Euler(eulerAngleVelocity * Time.deltaTime)
        #rigidbody.MoveRotation(rigidbody.rotation * deltaRotation)

        #fromRotation = transform.rotation; 
        #toRotation = Quaternion.Euler(x,y,z);
        #transform.rotation = Quaternion.Lerp(fromRotation,toRotation,Time.deltaTime * lerpSpeed);

        //pass
        #distance as single = Math.Abs(Vector3.Distance(vector3s[0],vector3s[1]))
        #time = distance/turningSpeed
        
        time = turningSpeed
        transform.rotation = Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(p), time * Time.deltaTime)

        // make zTilt slowly get bigger:
        #zTilt = zTilt + Time.deltaTime * turningSpeed;
        #if(zTilt > 90) zTilt = 90;

        #transform.rotation = Quaternion.Euler(0, 0, zTilt)

        #turnAngle as single = Mathf.Atan2(p.z, p.x) * Mathf.Rad2Deg
        #smoothAngle as single = Mathf.LerpAngle(transform.eulerAngles.y, -turnAngle, rigidbody.velocity.magnitude * Time.deltaTime)
        #rigidbody.MoveRotation(Quaternion.Euler(0, smoothAngle, transform.eulerAngles.z))
    
    def FixedUpdate():
        if moveDirection != Vector3.zero:
            Move()
        else: // No movement, straithen out
            pass
            # on the z axis    

        facingDir as Vector3
        if facingDirection != Vector3.zero:
            facingDir = facingDirection
        else:
            facingDir = moveDirection
        
        if facingDir != Vector3.zero:
            RotateTo(facingDir)
        else:
            pass
            # straighten out on z axis

