import UnityEngine

class MovementModule(MonoBehaviour): 
    public maxVelocity as single = 5000.0               // // maximum velocity
    public rotationSpeed as single = 8000.0             // maximum rotate speed
    public accelerationSpeed as single = 2000.0         // Acceleration speed
    public centerOfMass as Transform
    
    private unit as Unit
    private MoveToPosition as Vector3
    private move as bool = false
    #private targetAngle

    def Start():
        unit = gameObject.GetComponent(typeof(Unit))

        // Setup center of mass
        if centerOfMass != null:
            rigidbody.centerOfMass = centerOfMass.localPosition
    
    def FixedUpdate():
        if move:
            Move()
    
    def MoveTo(v as Vector3):
        MoveToPosition = v
        move = true

    def MoveToWaypoint():
        pass
    
    def Stop():
        move = false
        #gameobject.transform.position = Vector3.MoveTowards(gameObject.transform.position, unit.target.transform.position, unit.baseProperties.maxVelocity / 5)
    
    private def Move():
        #thrust = accelerationSpeed
        #turn = turnSpeed

        #targetAngle += 1 * turnSpeed * Time.deltaTime
        #targetDir = MoveToPosition - transform.position
        #angle = Vector3.Angle(targetDir, Vector3.forward)
        #angle = Quaternion.Angle(transform.rotation, target.rotation)
        #Debug.DrawLine(transform.position, transform.position + transform.forward, Color.red)
        #wantedRotationAngle = MoveToPosition.eulerAngles.y
        #currentRotationAngle = transform.eulerAngles.y
        #currentRotationAngle = Mathf.LerpAngle(currentRotationAngle, wantedRotationAngle, 3 * Time.deltaTime)

        #rigidbody.rotation = currentRotationAngle
        #transform.position.RotateTowards(transform.position, MoveToPosition, 1000, 1000)
        #Debug.Log(angle)
        #if angle > 5.0:
            #rigidbody.AddRelativeTorque(Vector3.up * turn * Time.deltaTime)

        // Rotate in the right direction
        rotation = Quaternion.LookRotation(MoveToPosition - transform.position)
        transform.rotation = Quaternion.Slerp(transform.rotation, rotation, Time.deltaTime * rotationSpeed)
        #transform.rotation = Quaternion.RotateTowards(transform.rotation, _direction, rotationSpeed * Time.deltaTime)
        #transform.LookAt(unit.target.transform)
        // Add force to move
        rigidbody.AddRelativeForce(Vector3.forward * accelerationSpeed * Time.deltaTime)
        // Limit velocity to maxspeed
        rigidbody.velocity = Vector3.ClampMagnitude(rigidbody.velocity, maxVelocity)

        // Stop when we are there
        #Debug.Log(Vector3.Distance(MoveToPosition, transform.position))
        distance = Vector3.Distance(MoveToPosition, transform.position)
        if distance <= 5:
            Stop()


        
        #weightDistance = 0.1;
        #weightSpeed = 0.1;
        #targetDir = MoveToPosition - transform.position
        #angularDistanceForTarget = Vector3.Angle(targetDir, Vector3.forward)
        #angularVelocity = rigidbody.angularVelocity.y

        #mod = (angularDistanceForTarget * weightDistance) - (angularVelocity * weightSpeed);
        #force = turnSpeed * Mathf.Clamp(mod, -1, 1)
        #rigidbody.AddRelativeTorque (Vector3.up * force)
        // Add force
        #rigidbody.AddRelativeForce(Vector3.forward * accelerationSpeed)
        #rigidbody.AddRelativeForce(Vector3.right * accelerationSpeed)


        /*
        targetDelta as Vector3 = MoveToPosition- transform.position
 
        //get the angle between transform.forward and target delta
        angleDiff as single = Vector3.Angle(transform.forward, targetDelta);
 
        // get its cross product, which is the axis of rotation to
        // get from one vector to the other
        cross as Vector3 = Vector3.Cross(transform.forward, targetDelta)
        #force = Vector3.forward * accelerationSpeed
        // apply torque along that axis according to the magnitude of the angle.
        rigidbody.AddTorque(cross * angleDiff * accelerationSpeed)
        */

        /*
        curPos = transform.position
        error = MoveToPosition - curPos; // generate the error signal
        integrator += error * Time.deltaTime; // integrate error
        diff = (error - lastError)/ Time.deltaTime; // differentiate error
        lastError = error;
        // calculate the force summing the 3 errors with respective gains:
        force = error * pGain + integrator * iGain + diff * dGain
        // clamp the force to the max value available
        force = Vector3.ClampMagnitude(force, accelerationSpeed)
        // apply the force to accelerate the rigidbody:
        rigidbody.AddForce(force)
        */
