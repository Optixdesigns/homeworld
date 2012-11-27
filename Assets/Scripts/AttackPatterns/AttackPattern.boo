import UnityEngine

/*
* Handles the attack pattern of an Unit
*/

[Serializable]
public abstract class AttackPattern(MonoBehaviour):
    [HideInInspector]
    public unit as Unit
    
    def Start():
        pass
        #unit = gameObject.GetComponent(typeof(Unit))
    
    def Update():
        pass

    /// Shortcut for getting the distance between positions
    def GetDistance(pos1 as Vector3, pos2 as Vector3):
        return Vector3.Distance(pos1, pos2)