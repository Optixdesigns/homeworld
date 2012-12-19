import UnityEngine

[Serializable]
class StraightAttackPattern(AttackPattern):
    public runStartDistance = 70 /// Distance needed to start a attack run
    public runEndDistance = 10 /// Distance to target wich ends a run
    private runStartPosition as Vector3 /// position to start a new run
    private onRun as bool = false

    private steerForTarget as SteerForTarget
    private steerForPoint as SteerForPoint
    private steerForEvasion as SteerForEvasion

    private distanceToTarget as single

    def OnEnable():
        runStartPosition = GetNewRerunPosition()
        steerForTarget = GetComponent(typeof(SteerForTarget))
        steerForPoint = GetComponent(typeof(SteerForPoint))
        steerForEvasion = GetComponent(typeof(SteerForEvasion))

        steerForTarget.Target = unit.target.transform

    def ExecuteRun():
        steerForTarget.enabled = true
        steerForPoint.enabled = false
        steerForEvasion.enabled = true

        if distanceToTarget < runEndDistance:
            runStartPosition = GetNewRerunPosition()
            onRun = false

    def ExecuteReRun():
        steerForPoint.TargetPoint = runStartPosition
        steerForTarget.enabled = false
        steerForPoint.enabled = true
        steerForEvasion.enabled = true
        
        if distanceToTarget >= runStartDistance:
            onRun = true 

    def Update():
        // Do nothing if no target
        if not unit.target:
            return

        steerForTarget.Target = unit.target.transform
        distanceToTarget = Vector3.Distance(unit.transform.position, unit.target.transform.position)

        if onRun:
            ExecuteRun()
        else:
            ExecuteReRun()
            #Debug.Log(runStartPosition)

    def GetNewRerunPosition():
        return unit.target.transform.position + Random.onUnitSphere * Random.Range(runStartDistance + 10, runStartDistance + 30)

        /*
        // Always face movement direction
        unit.movement.facingDirection = Vector3.zero

        // Calculate distance
        dist as single = GetDistance(unit.target.transform.position, unit.transform.position)

        #controls = fsm.gameObject.GetComponent(typeof(ShipControls))
        #controls.Thrust(0.1)

        #Debug.Log(unit.movement.moveDirection)
        
        if onRun:
            #Debug.Log(unit.target.transform.position)
            unit.movement.moveDirection = unit.target.transform.position
            // lookat target

            // Cancel run and create a start run point in space
            if dist < runEndDistance:
                runStartPosition = GetNewRerunPosition()
                onRun = false

        
        // Move away for a new run
        if not onRun:
            unit.movement.moveDirection = runStartPosition

            // Time todo a run again
            if dist >= runStartDistance:
                onRun = true
        */
            

        #return unit.target.transform.position + Vector3(Random.Range(runStartDistance, runStartDistance + 20), Random.Range(runStartDistance, runStartDistance + 20), Random.Range(runStartDistance, runStartDistance + 20))









        #if dist:
            #unit.transform.LookAt(unit.target.transform)
            #unit.rigidbody.velocity = unit.transform.forward * 10

        #targetDir as Vector3 = unit.target.transform.position - unit.transform.position
        #angleBetween = Vector3.Angle (transform.forward, targetDir);

