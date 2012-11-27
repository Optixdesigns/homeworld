import UnityEngine


class SidewayAttackPattern(AttackPattern):
    private attackMaxDistance = 25 /// Distance needed to start a attack run
    private attackMinDistance = 10 /// Distance to target wich ends a run
    private isInAttackDistance = false

    def Start():
        pass
    
    def Update():
        #Debug.Log(isInAttackDistance)
        // Calculate distance to target
        dist as single = GetDistance(unit.target.transform.position, unit.transform.position)
        if dist < attackMaxDistance and dist > attackMinDistance:
            isInAttackDistance = true
        else:
            isInAttackDistance = false    

        #Debug.Log("Attackdistance: " + isInAttackDistance)
        
        if not isInAttackDistance:
            #Debug.Log("asking to move")
            // Move our unit in attack range
            unit.movement.moveDirection = unit.target.transform.position
        
        // Move away for a new run
        elif isInAttackDistance:
            unit.movement.Stop()
            // Rotate unit in attack position (on it side, like pirates...raarrrr)
            #dir = unit.target.transform.rotation
            #dir = Quaternion.Euler(unit.transform.rotation.x, unit.transform.rotation.y + 90, unit.target.transform.rotation.z)
            #rotation = Quaternion.LookRotation(unit.target.transform.position - unit.transform.position)

            #Debug.Log(dir)
            #rot = Quaternion.Euler(unit.transform.rotation.x, unit.transform.rotation.y, unit.transform.rotation.z)
            #Debug.Log(rot * Vector3.forward)
            unit.movement.facingDirection = unit.transform.position + Vector3(0, 0, 90)




