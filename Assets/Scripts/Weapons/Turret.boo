import UnityEngine

[AddComponentMenu('New World/Weapons/Turret')]
public class Turret(Weapon):
    public pivot as Transform
    public yaw as Transform
    public pitch as Transform
    public barrels as (Transform)

    #public RateOfFire as single = 1.0
    public autoFire as bool // Weapon should autofire or not
    public range as single = -1   // Range of this turret, if any. - 1 is ignore
    public interval as single = 125 // fire interval
    public waitForAlignment as bool = true // Must the gun allign with target befor shooting
    public AlignmentTolerance as single = 5 // tollerance of the allignment
    public burst as single = 1

    public pitchMin as single = 5
    public pitchMax as single = 45
    public pitchSpeed as single = 10

    public yawRange as single = 90
    public yawSpeed as single = 10
    public limitYaw as bool = true

    public dampSpeed as single = 0.10000000149F
    public speedFactor as single = 1

    public ammoPrefab as GameObject
    
    #private targetTracker as TargetTracker
    private yawVelocity as single
    private pitchVelocity as single
    private fireIntervalCounter as single = 0

    private fireController as FireController

    def Awake():
        fireTimer = Time.time

        // Setup connection with the fire controller
        #fireController = self.GetComponent[of FireController]()
        #fireController.OnFireEvent += self.OnFireEv
        #fireController.OnTargetUpdateEvent += self.OnTargetUpdateEv

        // Get our target tracker
        #if not targetTracker:
            #targetTracker = gameObject.GetComponent(typeof(TargetTracker))

    /// React on firing
    def OnFireEv(targets as TargetList):
        Fire()

    /// Validate and get our target
    def OnTargetUpdateEv(targets as TargetList):
        // TODO CHECK IF WE CAN TARGET
        if targets.Count != 0:
            self.target = targets[0].transform

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

    // Can this turret yaw to target
    public def CanYawTarget(position as Vector3) as bool:
        if limitYaw:
            delta = (position - yaw.position)
            rot = Quaternion.FromToRotation(pivot.forward, delta).eulerAngles
            return AngleBetween(rot.y, -yawRange, yawRange)
        return true
    
    // Can this turret pitch to target
    public def CanPitchTarget(position as Vector3) as bool:
        delta = (position - pitch.position)
        rot = Quaternion.FromToRotation(yaw.forward, delta).eulerAngles
        return AngleBetween(rot.x, pitchMin, pitchMax)

    /// Check if target is alligned with gun
    public def TargetAlligned(position as Vector3) as bool:
        if not waitForAlignment:
            return true
        
        _angle = Vector3.Angle(pitch.forward, (target.transform.position - pitch.position))
        if _angle <= AlignmentTolerance:
            return true

        return false

    /// Is target in range
    public def TargetInRange(position as Vector3) as bool:
        if range == (-1):
            return true

        distance as single = Vector3.Distance(position, transform.position)
        if distance >= self.range:
            return true
        
        return false
        
    private def Update():
        
        #heat -= (Time.deltaTime * fireRateFactor)
        self.fireIntervalCounter -= Time.deltaTime

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
        
        if target and TargetAlligned(target.transform.position):
            Fire()
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
        if CanPitchTarget(position) and CanYawTarget(position) and (TargetInRange(position)):
            return true

        return false
    /*
    public def FindTarget():
        // Find a target from the targettracker pool
        if self.targetTracker:
           if self.targetTracker.targets.Count != 0:
                return self.targetTracker.targets[0]

        return null
    */

    public def Fire():
        if self.fireIntervalCounter <= 0:
            #fireTimer = Time.time + (coolDownTime * Time.deltaTime)
            self.fireIntervalCounter = self.interval
            StartCoroutine('_Fire')

    def _Fire() as IEnumerator:
        for b in range(0, burst):
            for i in range(0, barrels.Length):
                Instantiate(ammoPrefab, (barrels[i].position + (ammoPrefab.transform.localScale.z * barrels[i].forward)), barrels[i].rotation)
                #barrels[i].localPosition = (barrelPositions[i] - Vector3(0, 0, recoilLength))
            
            yield WaitForSeconds(0.3)   // wait a second or burst fire TODO CREATE A RANDOM RANGE FOR BETTER LOOK
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