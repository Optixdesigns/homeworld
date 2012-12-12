import UnityEngine

[Serializable]
class StraightAttackPattern(AttackPattern):
    public onRun as bool = false
    public runStartDistance = 25 /// Distance needed to start a attack run
    public runEndDistance = 5 /// Distance to target wich ends a run
    private runStartPosition as Vector3 /// position to start a new run

    def OnEnable():
        runStartPosition = GetNewRerunPosition()
        #pass
        /*
        dist as single = GetDistance(unit.target.transform.position, unit.transform.position)
        if dist > runEndDistance:
            onRun = true
        elif dist < runEndDistance:
            onRun = false
        */
    
    def Update():
        // Do nothing if no target
        if not unit.target:
            return

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
            #unit.movement.SmoothLookAt(unit.target.transform.position)
            // Move our unit
            #unit.movement.MoveTo(unit.target.transform.position)
 
            #if dist > runEndDistance: 
                #onRun = true

            // Cancel run and create a start run point in space
            if dist < runEndDistance:
                runStartPosition = GetNewRerunPosition()
                onRun = false

        
        // Move away for a new run
        if not onRun:
            unit.movement.moveDirection = runStartPosition
            #unit.movement.MoveTo(runStartPosition)
            #unit.movement.SmoothLookAt(rerunPosition)
            #if dist < runStartDistance:
                #onRun = false
            
            // Time todo a run again
            if dist >= runStartDistance:
                onRun = true
            

    def GetNewRerunPosition():
        return unit.target.transform.position + Random.onUnitSphere * Random.Range(runStartDistance, runStartDistance + 20)
        #return unit.target.transform.position + Vector3(Random.Range(runStartDistance, runStartDistance + 20), Random.Range(runStartDistance, runStartDistance + 20), Random.Range(runStartDistance, runStartDistance + 20))









        #if dist:
            #unit.transform.LookAt(unit.target.transform)
            #unit.rigidbody.velocity = unit.transform.forward * 10

        #targetDir as Vector3 = unit.target.transform.position - unit.transform.position
        #angleBetween = Vector3.Angle (transform.forward, targetDir);

