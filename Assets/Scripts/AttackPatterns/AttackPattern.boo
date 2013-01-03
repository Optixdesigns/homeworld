import UnityEngine

/*
* Handles the attack pattern of an Unit
*/

[Serializable]
public class AttackPattern(MonoBehaviour):
    [HideInInspector]
    public unit as Unit
    
    def Start():
        unit = gameObject.GetComponent(typeof(Unit))
    
    /// Shortcut for getting the distance between positions
    def GetDistance(pos1 as Vector3, pos2 as Vector3):
        return Vector3.Distance(pos1, pos2)