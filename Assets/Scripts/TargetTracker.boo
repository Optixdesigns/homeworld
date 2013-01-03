import UnityEngine

#enum radiusShape:
# TODO SORT BY RANGE/NEAREST
[AddComponentMenu('New World/Target/TargetTracker')]
class TargetTracker(MonoBehaviour):
    public numberOfTargets as int = 1
    #private targetList as (Targetable) = array(Targetable, 0)
    #public targetLaters as int

    #private static _cachedDetectableObjects as Dictionary[of Collider, Detectable] = Dictionary[of Collider, Detectable]()
    
    public layersChecked as LayerMask

    public range as single:
        get:
            return self._range
        set:
            self._range = value

            if self.perimeter:
                self.UpdatePerimeterShape()

    [SerializeField]
    private _range as single
    [SerializeField]
    public drawGizmo as bool = false
    
    private _perimeter as Perimeter
    public perimeter as Perimeter:
        get:
            return self._perimeter
        private set:
            self._perimeter = value

    #private _targets as List[of Target] = List[of Target]()
    #public targetList as (Target) = array(Target, 0)
    public targets as TargetList:
        get:
            if self.perimeter:
                return self.perimeter.targets

            return TargetList()
        set:
            pass

    def Awake():
        InitPerimeter()
    
    def Update ():
        pass

    def InitPerimeter():
        // Setup the perimiter object
        # TODO Create the size based of range
        p as GameObject = GameObject.CreatePrimitive(PrimitiveType.Sphere)
        p.name = "Radar Perimeter"
        p.tag = "Perimeter"
        p.transform.parent = transform
        p.transform.position = transform.position
        p.renderer.enabled = false
        self.perimeter = p.AddComponent[of Perimeter]()
        self.perimeter.targetTracker = self
        self.UpdatePerimeterShape()
        

    def UpdatePerimeterShape():
        (self.perimeter.collider as SphereCollider).radius = self._range
        (self.perimeter.collider as SphereCollider).isTrigger = true // no colliders

    def OnDrawGizmos():
        // Draw perimiter in editor
        if self.drawGizmo:
            pos = transform.position
            Gizmos.color = Color.cyan
            Gizmos.DrawWireSphere(pos, self.range)