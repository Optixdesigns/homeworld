import UnityEngine

/*
* Handles the attack pattern of an Unit
*/

public abstract class AttackPattern:
    abstract def Start(unit as Unit):
        pass
    
    abstract def Update(unit as Unit):
        pass

    /// Shortcut for getting the distance between positions
    def GetDistance(pos1 as Vector3, pos2 as Vector3):
        return Vector3.Distance(pos1, pos2)