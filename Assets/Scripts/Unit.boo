import UnityEngine
import System


[RequireComponent(typeof(AIBehaviours))]
[RequireComponent(typeof(HealthModule))]
[RequireComponent(typeof(WeaponsModule))]
[RequireComponent(typeof(MovementModule))]
[RequireComponent(typeof(Rigidbody))]
[AddComponentMenu('Neworld/Space Unit')]
class Unit(SpaceObject):
    #private _speed as single                // Current speed/velocity

    public target as GameObject // target
    [HideInInspector]
    public targetDistance as single // Distance to target
    
    #public moveToPosition as Vector3 // move to position
    public player as GameObject // Owner of this ship, should also hold stuff like color, alliance etc
    public isEnemy as bool = false // Is this an enemy?

    [HideInInspector]
    public fsm as AIBehaviours  /// Relation to the attached FSM
    
    [HideInInspector]
    public health as HealthModule
    [HideInInspector]
    public weapons as WeaponsModule
    [HideInInspector]
    public movement as MovementModule

    public select as SelectController
    #public baseProperties as UnitProperties

    public mass as single = 500 // in tons, must between 1 and 10.000
    public collisionRadius as single = 2.0 // Collision Radius
    public centerOfMass as Transform
    
    /*
    public override Speed as single:
        get:
            return _speed
        set:
            _speed = Mathf.Clamp(value, 0, MaxSpeed)
            DesiredSpeed = _speed

    public override Velocity as Vector3:
        get:
            return Transform.forward * _speed
        set:
            raise System.NotSupportedException("Cannot set the velocity directly on Unit")

    public override def UpdateOrientationVelocity(velocity as Vector3):
        Speed = velocity.magnitude
        OrientationVelocity = ((velocity / _speed) if (_speed != 0) else Transform.forward)

    protected override def CalculatePositionDelta(deltaTime as single) as Vector3:
        return (Velocity * deltaTime)

    protected override def ZeroVelocity():
        Speed = 0
    */    

    #private _collisionSphere as SphereCollider // Collision Sphere, used as trigger

    def Awake():
        // Setup initial values and references
        fsm = gameObject.GetComponent[of AIBehaviours]() // REQUIRED
        health = gameObject.GetComponent[of HealthModule]() // REQUIRED
        weapons = gameObject.GetComponent[of WeaponsModule]() // REQUIRED
        movement = gameObject.GetComponent[of MovementModule]() // REQUIRED
        
        // Set rigibody
        rigidbody.detectCollisions = false // For now

        // Setup center of mass
        if centerOfMass != null:
            rigidbody.centerOfMass = centerOfMass.localPosition

        // Set mass of rigidbody
        rigidbody.mass = mass / 1000

        // Setup collision sphere
        #_collisionSphere = gameObject.AddComponent("SphereCollider")
        #_collisionSphere.radius = baseProperties.collisionRadius
        #_collisionSphere.isTrigger = true
        #print(_collisionSphere.Rigidbody)

        #print(collider)

        // Check our setup
        #if movement.maxVelocity == 0.0:
            #Debug.Log("WARNING: Ships maximum velocity is zero")

    def Update():
        if target:  // Keep distance in the unit object for different systems
            targetDistance = Vector3.Distance(target.transform.position, transform.position)

    def setTarget(t as GameObject):
        target = t

    def setTargetPosition(p as Vector3):
        targetPosition = p

    /*
    * Receivers
    */

    /// Shoot receiver
    #def Shoot():
        # VALIDATE TARGET
        #weapons.Shoot(target)

    /// Selected state receiver
    def IsSelected(s as bool):
        select.isSelected = s   

    /*
    def OnCollisionEnter(collision as Collision):
        print("collision")
        Debug.Log("yes")

    def OnTriggerEnter(collider as Collider):
        // Debug-draw all contact points and normals
        #for contact as ContactPoint in collision.contacts:
            #Debug.DrawRay(contact.point, contact.normal, Color.white)
        
        print("collision")
        Debug.Log("yes")
        #behaviours.ChangeState(behaviours.behaviourOnIdle)
    */
