import UnityEngine

#enum radiusShape:
# TODO SORT BY RANGE/NEAREST
[AddComponentMenu('New World/Target/TargetTracker')]
class TargetTracker(MonoBehaviour):
    public numberOfTargets as int = 1
    #private targetList as (Targetable) = array(Targetable, 0)
    #public targetLaters as int

    #private static _cachedDetectableObjects as Dictionary[of Collider, Detectable] = Dictionary[of Collider, Detectable]()
    #[LayerField]
    #public test as int
    public targetLayers as LayerMask
    #public perimeterLayer as LayerMask
    #public inLineOfSight as bool = false   // Should targets be in line of sight, should not be obstructed


    public range as single:
        get:
            return self._range
        set:
            self._range = value

            if self.perimeter:
                self.UpdatePerimeterShape()

    #[Layer]
    public perimeterLayer as int:
        get:
            return self._perimeterLayer
        set:
            self._perimeterLayer = value

            if self.perimeter:
                self.perimeter.gameObject.layer = value

    [SerializeField]  // Private backing fields must be SerializeField. For instances.
    private _perimeterLayer as int = LayerMask.NameToLayer("Perimeters")
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

    public debugLevel as DEBUG_LEVELS = DEBUG_LEVELS.Off

    /// A list of sorted targets
    public targets as TargetList:
        get:
            self._targets.Clear()

            // Perimeter needed
            if not self.perimeter:
                return self._targets

            // No targets, quit
            if self.numberOfTargets == 0 or self.perimeter.Count == 0:
                return self._targets
            
            // Get Everything
            if self.numberOfTargets == (-1):
                self._targets.AddRange(self.perimeter)
            else:
                // Grab the first item(s)
                num as int = Mathf.Clamp(self.numberOfTargets, 0, self.perimeter.Count)
                for i in range(0, num):
                    self._targets.Add(self.perimeter[i])
            
            if self.debugLevel > DEBUG_LEVELS.Normal:
                // All higher than normal
                msg as string = string.Format('returning targets: {0}', self._targets.ToString())
                Debug.Log(string.Format('{0}: {1}', self, msg))

            return self._targets
        set:
            pass

     private _targets as TargetList = TargetList()

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
        p.layer = self.perimeterLayer
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