import UnityEngine


public abstract class Weapon(MonoBehaviour):
    public projectilePrefab as GameObject
    public RateOfFire as single = 1.0
    public fieldOfViewRange as single = 50
    public target as Target // Current target
    public autoFire as bool
    public range as single = 50
    private targetTracker as TargetTracker
    public fireTimer as single // cooldown timer

    def Awake():
        // Get our target tracker
        if not targetTracker:
            targetTracker = gameObject.GetComponent(typeof(TargetTracker))

    def Start():
        #unit = gameObject.GetComponent(typeof(Unit))
        fireTimer = Time.time + RateOfFire
    
    def Update():
        // Validate target and fire
        if self.autoFire and ValidateTarget(self.target):
            Fire()
            
        // Find target
        #if self.autoFire and self.target:
        if self.autoFire:
            self.target = FindTarget()

    protected virtual def RecalculateScaledValues():
        pass

    protected virtual def TargetInRange(target as Target) as bool:
        distance as single = Vector3.Distance(self.target.transform.position, transform.position)
        if distance >= self.range:
            return true
        
        return false
        /*
        rayDirection as Vector3 = t.position - transform.position
        angle as single = Vector3.Angle(rayDirection, transform.forward)
        if angle < fieldOfViewRange and (unit.targetDistance > minShootDistance and unit.targetDistance < maxShootDistance):
            Debug.Log("target is in range")
            return true
        
        return false
        */


    # TODO CREATE COROUTINE FOR A TIMOUT MAYBE IT FLIES BACK INTO RANGE
    public def ValidateTarget(target as Target) as bool:
        // Check distance and allignment
        if TargetInRange(target):
            return true

        return false

    public def FindTarget():
        // Find a target from the targettracker pool
        if self.targetTracker:
           if self.targetTracker.targets.Count != 0:
                return self.targetTracker.targets[0]

        return null

    // Fire this weapon
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
