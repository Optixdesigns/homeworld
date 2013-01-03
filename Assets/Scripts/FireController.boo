import UnityEngine
import System.Collections
import System.Collections.Generic


[RequireComponent(typeof(TargetTracker))]
[AddComponentMenu('New World/Weapons/Fire Controller')]
class FireController(MonoBehaviour):
    public interval as single
    public initIntervalCountdownAtZero = true
    public notifyTargets as NOTIFY_TARGET_OPTIONS = NOTIFY_TARGET_OPTIONS.Direct
    public enum NOTIFY_TARGET_OPTIONS:
        Off
        Direct
        PassToProjectile
        UseProjectileEffects

    public ammoPrefab as Transform
    public _effectsOnTarget as List[of HitEffectGUIBacker] = List[of HitEffectGUIBacker]()

    // Encodes / Decodes HitEffects to and from HitEffectGUIBackers
    public effectsOnTarget as HitEffectList:
        get:
            // Convert the stored _effectsOnTarget backing field to a list of HitEffects
            returnHitEffectsList = HitEffectList()
            for effectBacker in self._effectsOnTarget:
                // Create and add a struct-form of the backing-field instance
                returnHitEffectsList.Add(HitEffect())
            
            return returnHitEffectsList
        set:
            
            // Convert and store the bassed list of HitEffects as HitEffectGUIBackers
            // Clear and set the backing-field list also used by the GUI
            self._effectsOnTarget.Clear()
            
            effectBacker as HitEffectGUIBacker
            for effect in value:
                effectBacker = HitEffectGUIBacker(effect)
                self._effectsOnTarget.Add(effectBacker)

    
    public waitForAlignment = false
    public flatAngleCompare = false
    public emitter as Transform
    public lockOnAngleTolerance as single = 5
    public debugLevel as DEBUG_LEVELS = DEBUG_LEVELS.Off
    public fireIntervalCounter as single = 99999
    // Keeps the state of each individual foldout item during the editor session
    public _editorListItemStates as Dictionary[of object, bool] = Dictionary[of object, bool]()
    public targetTracker as TargetTracker
    
    private targets = TargetList()
    
    private isLockedOnTarget as bool:
        get:
            if not self.waitForAlignment:
                return true
            
            targetDir as Vector3 = (self.targets[0].transform.position - self.emitter.position)
            forward as Vector3 = self.emitter.forward
            if self.flatAngleCompare:
                targetDir.y = (forward.y = 0)
            // Flaten Vectors
            angle as single = Vector3.Angle(targetDir, forward)
            
            // Just for debug. Show a gizmo line to each target being tracked
            //   OnFire() has another color, so keep this here where this 
            //   won't overlay the OnFired line.
            if self.debugLevel > DEBUG_LEVELS.Off:
                Debug.DrawRay(self.emitter.position, (targetDir * 3), Color.cyan)
                Debug.DrawRay(self.emitter.position, (forward * 3), Color.cyan)
            
            if angle < self.lockOnAngleTolerance:
                return true
            else:
                return false
    
    private targetsString as string:
        get:
            names as (string) = array(string, self.targets.Count)
            i = 0
            for target as Target in self.targets:
                names[i] = target.transform.name
                i += 1
            return System.String.Join(', ', names)
    
    #region Events
    def Awake():
        // Emitter is optional
        if self.emitter is null:
            self.emitter = self.transform
        
        if self.targetTracker is null:
            self.targetTracker = self.GetComponent[of TargetTracker]()
        // Required Component

    private def OnFire():
        // Log a message to show what is being fired on
        if self.debugLevel > DEBUG_LEVELS.Off:
            msg as string = string.Format('Firing on: {0}\nHitEffects{1}', self.targetsString, self.effectsOnTarget.ToString())
            Debug.Log(string.Format('{0}: {1}', self, msg))
        
        // Create a new list of targets which have this target tracker reference.
        targetCopies = TargetList()
        target as Target
        for inTarget as Target in self.targets:
            // Can't edit a struct in a foreach loop, so need to copy and store
            target = Target(inTarget)
            #target.fireController = self
            // Add reference. null before t
            targetCopies.Add(target)
            converterGeneratedName1 = self.notifyTargets
            
            if converterGeneratedName1 == NOTIFY_TARGET_OPTIONS.Direct:
                target.targetable.OnHit(self.effectsOnTarget, target)
                self.SpawnAmmunition(target, false, false)
            elif converterGeneratedName1 == NOTIFY_TARGET_OPTIONS.PassToProjectile:
            
                self.SpawnAmmunition(target, true, true)
            elif converterGeneratedName1 == NOTIFY_TARGET_OPTIONS.UseProjectileEffects:
            
                self.SpawnAmmunition(target, true, false)
            
            
            if self.notifyTargets > NOTIFY_TARGET_OPTIONS.Off:
                
                // Just for debug. Show a gizmo line when firing
                if self.debugLevel > DEBUG_LEVELS.Off:
                    Debug.DrawLine(self.emitter.position, target.transform.position, Color.red)
        
        // Write the result over the old target list. This is for output so targets
        //   which are handled at all by this target tracker are stamped with a 
        //   reference.
        self.targets = targetCopies
        #onFireDelegates(self.targets)
        
        // Trigger the delegates

    private def SpawnAmmunition(target as Target, passTarget as bool, passEffects as bool):
        // This is optional. If no ammo prefab is set, quit quietly
        if self.ammoPrefab is null:
            return
        
        #inst as Transform = TargetPro.InstanceManager.Spawn(self.ammoPrefab.transform, self.emitter.position, self.emitter.rotation)
        inst as Transform = Instantiate(self.ammoPrefab.transform, self.emitter.position, self.emitter.rotation)
        
        // Nothing left to do, this is probably a direct-damage effect, like a laser
        if not passTarget:
            return
        
        // Projectile....
        projectile = inst.GetComponent[of Projectile]()
        if projectile is null:
            // Protection
            msg = string.Format('Ammo \'{0}\' must have an Projectile component', inst.name)
            Debug.Log(string.Format('{0}: {1}', self, msg))
            
            return
        
        // Pass informaiton
        #projectile.fireController = self
        projectile.target = target
        
        if passEffects:
            projectile.effectsOnTarget = self.effectsOnTarget
    
    private def FiringSystem() as IEnumerator:
        // While (true) because of the timer, we want this to run all the time, not 
        //   start and stop based on targets in range
        if self.initIntervalCountdownAtZero:
            self.fireIntervalCounter = 0
        else:
            self.fireIntervalCounter = self.interval
        
        self.targets.Clear()
        #self.OnStart()
        // EVENT TRIGGER
        while true:
            // if there is no target, counter++, handle idle behavior, and 
            //   try next frame.
            // Will init this.targets for child classes as well.
            self.targets = self.targetTracker.targets
            if self.targets.Count != 0:
                // if all is right, fire 
                if (self.fireIntervalCounter <= 0) and self.isLockedOnTarget:
                    self.OnFire()
                    self.fireIntervalCounter = self.interval
                elif self.debugLevel > DEBUG_LEVELS.Off:
                // Reset
                    // Just for debug. Show a gizmo line to each target being tracked
                    //   OnFire() has another color, so keep this here where this 
                    //   won't overlay the OnFired line.
                    for target as Target in targets:
                        Debug.DrawLine(self.emitter.position, target.transform.position, Color.gray)
                
                // Update event while tracking a target
                #self.OnTargetUpdate(targets)
            else:
                pass
                // EVENT TRIGGER
                // Update event while NOT tracking a target
                #self.OnIdleUpdate()
                // EVENT TRIGGER
            
            self.fireIntervalCounter -= Time.deltaTime
            
            // Update event no matter what
            #self.OnUpdate()
            // EVENT TRIGGER
            // Stager calls to get Target (the whole system actually)
            #yield null

    public def FireImmediately(resetIntervalCounter as bool):
        if resetIntervalCounter:
            self.fireIntervalCounter = self.interval
        
        self.OnFire()

    def OnEnable():
        self.StartCoroutine(self.FiringSystem())
        // Start event is inside this

    def OnDisable():
        // This has to be here because if it is in the TargetingSystem coroutine
        //   when the coroutine is stopped, it will get skipped, not ran last.
        // Clean up...
        // Clear the list so we don't keep garbage around for no reason.
        self.targets.Clear()
    

