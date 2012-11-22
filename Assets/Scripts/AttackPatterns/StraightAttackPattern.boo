import UnityEngine

class StraightAttackPattern(AttackPattern):
    private onRun as bool = false
    private runStartDistance = 20 /// Distance needed to start a attack run
    private runEndDistance = 4 /// Distance to target wich ends a run
    private rerunPosition as Vector3 /// position to start a new run

    override def Start(unit as Unit):
        rerunPosition = GetNewRerunPosition(unit)
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
        Debug.Log(dist)
        
        if onRun:
            // Only move when on a safe distance and a run is active
            if dist > runEndDistance: 
                unit.transform.position = Vector3.MoveTowards(unit.transform.position, unit.target.transform.position, unit.baseProperties.maxVelocity / 5)
                #unit.rigidbody.AddRelativeForce(Vector3.forward * 10)
                onRun = true
                Debug.Log("running")
            // Cancel run and create a start run point in space
            elif dist < runEndDistance:
                rerunPosition = GetNewRerunPosition(unit)
                onRun = false
                Debug.Log("Cancel onrun")
        
        // Move away for a new run
        if not onRun:
            if dist < runStartDistance:
                #Vector3.MoveTowards(unit.transform.position, rerunPosition, unit.baseProperties.maxVelocity)
                unit.transform.Translate(Vector3.forward * unit.baseProperties.maxVelocity / 5)
                onRun = false
                Debug.Log("move away to: " + rerunPosition)
            // Time todo a run again
            elif dist > runStartDistance:
                onRun = true
                Debug.Log("start rerun")
            

    def GetNewRerunPosition(unit as Unit):
        #Debug.Log("Creating new rerun position:" + unit.transform.position + Vector3(0, 0, runStartDistance))
        return unit.transform.position + Vector3(0, 0, runStartDistance)









        #if dist:
            #unit.transform.LookAt(unit.target.transform)
            #unit.rigidbody.velocity = unit.transform.forward * 10

        #targetDir as Vector3 = unit.target.transform.position - unit.transform.position
        #angleBetween = Vector3.Angle (transform.forward, targetDir);

