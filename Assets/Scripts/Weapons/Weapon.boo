import UnityEngine

public abstract class Weapon(MonoBehaviour):
    public projectilePrefab as GameObject
    public RateOfFire as single = 1.0
    
    public fieldOfViewRange as single = 50
    public target as Transform
    public modus as string

    public minShootDistance as single = 5.0    // Attack range minum
    public maxShootDistance as single = 20.0   // Attack range maximum

    public targetTracker as TargetTracker
    #private unit as Unit

    [HideInInspector]
    public fireTimer as single // cooldown timer

    def Awake():
        if not targetTracker:
            targetTracker = gameObject.GetComponent(typeof(TargetTracker))

    def Start():
        #unit = gameObject.GetComponent(typeof(Unit))
        fireTimer = Time.time + RateOfFire
    
    def Update():
        pass

    protected virtual def RecalculateScaledValues():
        pass

    protected virtual def TargetInRange(t as Transform) as bool:
        rayDirection as Vector3 = t.position - transform.position
        angle as single = Vector3.Angle(rayDirection, transform.forward)
        if angle < fieldOfViewRange and (unit.targetDistance > minShootDistance and unit.targetDistance < maxShootDistance):
            Debug.Log("target is in range")
            return true
        
        return false

    public def Fire():
        if Time.time > fireTimer and TargetInRange(target):
            clone as GameObject = Instantiate(projectilePrefab, transform.position, transform.rotation)
            #clone.GetComponent(typeof(Projectile)).speed = unit.movement.Speed // Same momentum as this object
            fireTimer = Time.time + RateOfFire

    def OnDrawGizmosSelected():
        // Debug attack field of view
        totalFOV as single = 70.0f;
        rayRange as  single = fieldOfViewRange;
        halfFOV as single = totalFOV / 2.0f;
        leftRayRotation as Quaternion = Quaternion.AngleAxis( -halfFOV, Vector3.up )
        rightRayRotation as Quaternion = Quaternion.AngleAxis( halfFOV, Vector3.up )
        leftRayDirection as Vector3 = leftRayRotation * transform.forward
        rightRayDirection as Vector3 = rightRayRotation * transform.forward
        Gizmos.DrawRay( transform.position, leftRayDirection * rayRange )
        Gizmos.DrawRay( transform.position, rightRayDirection * rayRange )
