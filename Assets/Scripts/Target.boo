import UnityEngine
import System.Collections
import System.Collections.Generic

public struct Target(System.IComparable[of Target]):

    // Target cache
    public gameObject as GameObject
    public transform as Transform
    public targetable as Targetable
    public targetTracker as TargetTracker

    public def constructor(transform as Transform, targetTracker as TargetTracker):
        self.gameObject = transform.gameObject
        self.transform = transform
        self.targetable = self.transform.GetComponent[of Targetable]()
        self.targetTracker = targetTracker

    public static Null as Target:
        get:
            return _Null

    private static _Null = Target()

    // These are required to shut the cimpiler up when == or != is overriden
    // This are implimented as recomended by the msdn documentation.
    public override def GetHashCode() as int:
        return super.GetHashCode()

    public override def Equals(other as object) as bool:
        if other is null:
            return false
        return (self == (other cast Target))

    public def CompareTo(obj as Target):
        return (1 if (self.gameObject == obj.gameObject) else 0)

/*
public class TargetList(List[of Target]):

    public override def ToString() as string:
        names as (string) = array(string, super.Count)
        i = 0
        super.ForEach(def (target as Target):
            if target.transform is null:
                return
            
            names[i] = target.transform.name
            i += 1
)
        
        return System.String.Join(', ', names)
*/

