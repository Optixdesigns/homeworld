import UnityEngine
import System.Collections
 
[RequireComponent (Rigidbody)]
class ShipControls (MonoBehaviour):
    public hoverHeight = 3F
    public hoverHeightStrictness = 1F
    public forwardThrust = 5000F
    public backwardThrust = 2500F
    public bankAmount = 0.1F
    public bankSpeed = 0.2F
    public bankAxis = Vector3(-1F, 0F, 0F)
    public turnSpeed = 8000F
 
    public forwardDirection = Vector3(1F, 0F, 0F)
 
    public mass = 5F
 
    // positional drag
    public sqrdSpeedThresholdForDrag = 25F
    public superDrag = 2F
    public fastDrag = 0.5F
    public slowDrag = 0.01F
 
    // angular drag
    public sqrdAngularSpeedThresholdForDrag = 5F
    public superADrag = 32F
    public fastADrag = 16F
    public slowADrag = 0.1F
 
    public playerControl = true
 
    public bank = 0F
 
    def SetPlayerControl(control as bool):
        playerControl = control
 
    def Start():
        rigidbody.mass = mass
 
    def FixedUpdate():
        if Mathf.Abs(thrust) > 0.01:
            if rigidbody.velocity.sqrMagnitude > sqrdSpeedThresholdForDrag:
                rigidbody.drag = fastDrag
            else:
                rigidbody.drag = slowDrag
        else:
            rigidbody.drag = superDrag
 
        if Mathf.Abs(turn) > 0.01:
            if rigidbody.angularVelocity.sqrMagnitude > sqrdAngularSpeedThresholdForDrag:
                rigidbody.angularDrag = fastADrag
            else:
                rigidbody.angularDrag = slowADrag
        else:
            rigidbody.angularDrag = superADrag
 
        transform.position = Vector3.Lerp(transform.position, Vector3(transform.position.x, hoverHeight, transform.position.z), hoverHeightStrictness)
 
        amountToBank as single = rigidbody.angularVelocity.y * bankAmount
 
        bank = Mathf.Lerp(bank, amountToBank, bankSpeed)
 
        rotation = transform.rotation.ToEulerAngles()
        rotation.x = 0F
        rotation.z = 0F
        rotation += bankAxis * bank
        transform.rotation = Quaternion.EulerAngles(rotation)
 
    thrust = 0F
    turn = 0F
 
    def Thrust(t as single):
        turn = Mathf.Clamp(t, -1F, 1F) * turnSpeed
 
    def Turn(t as single):
        turn = Mathf.Clamp(t, -1F, 1F) * turnSpeed
 
    thrustGlowOn = false
 
    def Update ():
        theThrust = thrust
 
        if (playerControl):
            thrust = Input.GetAxis("Vertical")
            turn = Input.GetAxis("Horizontal") * turnSpeed
 
        if (thrust > 0.0):
            theThrust *= forwardThrust
            if (not thrustGlowOn):
                thrustGlowOn = not thrustGlowOn
                BroadcastMessage("SetThrustGlow", thrustGlowOn, SendMessageOptions.DontRequireReceiver)
        else:
            theThrust *= backwardThrust
            if (thrustGlowOn):
                thrustGlowOn = not thrustGlowOn
                BroadcastMessage("SetThrustGlow", thrustGlowOn, SendMessageOptions.DontRequireReceiver)
 
        rigidbody.AddRelativeTorque(Vector3.up * turn * Time.deltaTime)
        rigidbody.AddRelativeForce(forwardDirection * theThrust * Time.deltaTime)