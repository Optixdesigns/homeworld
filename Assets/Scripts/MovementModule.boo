import UnityEngine

class MovementModule(MonoBehaviour): 
    public maxVelocity as single = 1.0               // // maximum velocity
    public maxRotate as single = 1.0             // maximum rotate speed
    public accelerationSpeed as single = 1.0         // Acceleration speed
    
    private unit as Unit

    def Start ():
        unit = gameObject.GetComponent(typeof(Unit))
    
    def Update ():
        pass

    def Move():
        // Add force
        rigidbody.AddRelativeForce(Vector3.forward * accelerationSpeed)
        // Limit velocity to maxspeed
        rigidbody.velocity = Vector3.ClampMagnitude(rigidbody.velocity, maxVelocity)
    
    def MoveTo():
        pass
    
    def Stop():
        pass
        #gameobject.transform.position = Vector3.MoveTowards(gameObject.transform.position, unit.target.transform.position, unit.baseProperties.maxVelocity / 5)
    
    /// Looking smooth....
    def SmoothLookAt(p as Vector3):
        rotation = Quaternion.LookRotation(p - transform.position);
        transform.rotation = Quaternion.Slerp(transform.rotation, rotation, maxRotate * Time.deltaTime)