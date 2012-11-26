import UnityEngine

class StraightAttackPattern(AttackPattern):
    private onRun as bool = false
    private runStartDistance = 25 /// Distance needed to start a attack run
    private runEndDistance = 6 /// Distance to target wich ends a run
    private runStartPosition as Vector3 /// position to start a new run

    override def Start(unit as Unit):
        runStartPosition = GetNewRerunPosition(unit)
        #pass
        /*
        dist as single = GetDistance(unit.target.transform.position, unit.transform.position)
        if dist > runEndDistance:
            onRun = true
        elif dist < runEndDistance:
            onRun = false
        */
    
    override def Update(unit as Unit):
        // Do a rerun

        // Calculate distance
        dist as single = GetDistance(unit.target.transform.position, unit.transform.position)

        #Debug.Log(rerunPosition)
        
        if onRun:
            // lookat target
            #unit.movement.SmoothLookAt(unit.target.transform.position)
            // Move our unit
            unit.movement.MoveTo(unit.target.transform.position)
 
            #if dist > runEndDistance: 
                #onRun = true

            // Cancel run and create a start run point in space
            if dist < runEndDistance:
                runStartPosition = GetNewRerunPosition(unit)
                onRun = false

        
        // Move away for a new run
        if not onRun:
            unit.movement.MoveTo(runStartPosition)
            #unit.movement.SmoothLookAt(rerunPosition)
            #if dist < runStartDistance:
                #onRun = false
            
            // Time todo a run again
            if dist >= runStartDistance:
                onRun = true
            

    def GetNewRerunPosition(unit as Unit):
        return unit.target.transform.position + Vector3(Random.Range(runStartDistance, runStartDistance + 20), Random.Range(runStartDistance, runStartDistance + 20), Random.Range(runStartDistance, runStartDistance + 20))









        #if dist:
            #unit.transform.LookAt(unit.target.transform)
            #unit.rigidbody.velocity = unit.transform.forward * 10

        #targetDir as Vector3 = unit.target.transform.position - unit.transform.position
        #angleBetween = Vector3.Angle (transform.forward, targetDir);

