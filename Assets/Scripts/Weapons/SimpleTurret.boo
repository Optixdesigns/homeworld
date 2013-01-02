import UnityEngine

public class SimpleTurret(Weapon):
    public pivot as Transform
    public yaw as Transform
    public pitch as Transform
    public barrels as (Transform)
    public target as Transform // Current target as Transform

    public RateOfFire as single = 1.0
    public autoFire as bool // Weapon should autofire or not
    public range as single = 50 // Range of this gun
    public coolDown as single = 2 // cooldown timer
    public mustAllign as bool = true // Must the gun allign with target befor shooting
    public accuracy as single = 0 // accuracy of the turret
    public burst as single = 1

    public pitchMin as single = 5
    public pitchMax as single = 45
    public pitchSpeed as single = 10

    public yawRange as single = 90
    public yawSpeed as single = 10
    public limitYaw as bool = true

    public dampSpeed as single = 0.10000000149F
    public speedFactor as single = 1

    public projectilePrefab as GameObject
    
    private targetTracker as TargetTracker
    private yawVelocity as single
    private pitchVelocity as single
    private fireTimer as single

    def Awake():
        fireTimer = Time.time
        // Get our target tracker
        if not targetTracker:
            targetTracker = gameObject.GetComponent(typeof(TargetTracker))

    private def AngleInRange(A as single, D as single) as bool:
        if (A < (360 - D)) and (A > 180):
            return false
        if (A > D) and (A < 180):
            return false
        return true

    private def AngleBetween(angle as single, A as single, B as single) as bool:
        angle = ((360 + (angle % 360)) % 360)
        A = ((360 + (A % 360)) % 360)
        B = ((360 + (B % 360)) % 360)
        if A < B:
            return ((A <= angle) and (angle <= B))
        return ((A <= angle) or (angle <= B))

    public def CanYawTarget(position as Vector3) as bool:
        if limitYaw:
            delta = (position - yaw.position)
            rot = Quaternion.FromToRotation(pivot.forward, delta).eulerAngles
            return AngleBetween(rot.y, -yawRange, yawRange)
        return true
    
    public def CanPitchTarget(position as Vector3) as bool:
        delta = (position - pitch.position)
        rot = Quaternion.FromToRotation(yaw.forward, delta).eulerAngles
        return AngleBetween(rot.x, pitchMin, pitchMax)
        
    /*
    def Update():
        // Validate target and fire
        if self.autoFire and CanTarget(self.target.transform.position):
            Fire()
            
        // Find target
        #if self.autoFire and self.target:
        if self.autoFire:
            self.target = FindTarget()
    */
    private def Update():
        
        #heat -= (Time.deltaTime * fireRateFactor)

        if target:
            E = yaw.localEulerAngles
            targetYaw = E.y
            if CanYawTarget(target.transform.position):
                LP = transform.InverseTransformPoint(target.transform.position)
                A = Vector3.Angle(Vector3(LP.x, 0, LP.z), Vector3.forward)
                targetYaw = (A * ((-1) if (LP.x < 0) else 1))
                E.y = Mathf.SmoothDampAngle(E.y, targetYaw, yawVelocity, dampSpeed, (yawSpeed * speedFactor))
                yaw.localEulerAngles = E
                
            if CanPitchTarget(target.transform.position):
                if Mathf.Abs(Mathf.DeltaAngle(E.y, targetYaw)) < 30:
                    LP = yaw.InverseTransformPoint((target.transform.position + (Vector3.down * pitch.localPosition.y)))
                    A = Vector3.Angle(Vector3(0, LP.y, LP.z), Vector3.forward)
                    PE = pitch.localEulerAngles
                    targetPitch = ((-A) * ((-1) if (LP.y < 0) else 1))
                    PE.x = Mathf.SmoothDampAngle(PE.x, targetPitch, pitchVelocity, dampSpeed, (pitchSpeed * speedFactor))
                    pitch.localEulerAngles = PE

            #for i in range(0, barrels.Length):
                #barrels[i].localPosition = Vector3.Lerp(barrels[i].localPosition, barrelPositions[i], (Time.deltaTime * speedRecoil))
            
            #accuracy = Vector3.Angle(pitch.forward, (target.transform.position - pitch.position))
        
        if target:
            Fire()

    protected virtual def TargetInRange(position as Vector3) as bool:
        distance as single = Vector3.Distance(position, transform.position)
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

    #public bool CanTarget (Vector3 position)
    #{
        #return CanPitchTarget (position) && CanYawTarget (position);
    #}
    # TODO CREATE COROUTINE FOR A TIMOUT MAYBE IT FLIES BACK INTO RANGE
    public def CanTarget(position as Vector3) as bool:
        // Check distance and allignment
        if CanPitchTarget(position) and CanYawTarget(position) and TargetInRange(position):
            return true

        return false

    public def FindTarget():
        // Find a target from the targettracker pool
        if self.targetTracker:
           if self.targetTracker.targets.Count != 0:
                return self.targetTracker.targets[0]

        return null

    public def Fire():
        if Time.time > fireTimer:
            fireTimer = Time.time + coolDown
            StartCoroutine('_Fire')

    def _Fire() as IEnumerator:
        for b in range(0, burst):
            for i in range(0, barrels.Length):
                projectile as GameObject = Instantiate(projectilePrefab, (barrels[i].position + (projectilePrefab.transform.localScale.z * barrels[i].forward)), barrels[i].rotation)
                #barrels[i].localPosition = (barrelPositions[i] - Vector3(0, 0, recoilLength))
            
            yield WaitForSeconds(0.5)   // wait a second or burst fire TODO CREATE A RANDOM RANGE FOR BETTER LOOK
        #clone as GameObject = Instantiate(projectilePrefab, transform.position, transform.rotation)
        

    /*
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
    */