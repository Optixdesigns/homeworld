import UnityEngine

[Serializable]
class StraightAttackPattern(AttackPattern):
    public runStartDistance = 25 /// Distance needed to start a attack run
    public runEndDistance = 5 /// Distance to target wich ends a run
    private runStartPosition as Vector3 /// position to start a new run
    private onRun as bool = false

    private steerForTarget as SteerForTarget

    def OnEnable():
        runStartPosition = GetNewRerunPosition()
        steerForTarget = GetComponent(typeof(SteerForTarget))

    def Update():
        // Do nothing if no target
        if not unit.target:
            return

        # = GetComponent(typeof(SteerForTarget))
        steerForTarget.Target = unit.target.transform
        steerForTarget.enabled = true
        
        #if unit.radar
        if steerForTarget.enabled:
            distance = Vector3.Distance(unit.transform.position, unit.target.transform.position)
            #Debug.Log(distance)
            
            if distance < runStartDistance and distance > runEndDistance:
                steerForTarget.enabled = false
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
            

    def GetNewRerunPosition():
        return unit.target.transform.position + Random.onUnitSphere * Random.Range(runStartDistance, runStartDistance + 20)
        #return unit.target.transform.position + Vector3(Random.Range(runStartDistance, runStartDistance + 20), Random.Range(runStartDistance, runStartDistance + 20), Random.Range(runStartDistance, runStartDistance + 20))









        #if dist:
            #unit.transform.LookAt(unit.target.transform)
            #unit.rigidbody.velocity = unit.transform.forward * 10

        #targetDir as Vector3 = unit.target.transform.position - unit.transform.position
        #angleBetween = Vector3.Angle (transform.forward, targetDir);

