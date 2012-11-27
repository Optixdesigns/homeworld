import UnityEngine
import System.Collections


class Utils:

    AllScripts as Dictionary[of string, AttackPattern] = Dictionary[of string, AttackPattern]()
    
    public def _ListScriptObjects():

        AllScripts.Clear()

        #scripts as (UnityEngine.Object) = Resources.LoadAll("Scripts", typeof(AttackPattern))
        scripts = Resources.LoadAll("Materials")
        #Debug.Log(scripts)
        #Debug.Log(scripts.Count.ToString())

        for script as UnityEngine.Object in scripts:
            Debug.Log("yo")
            if script.GetType().Equals(typeof(AttackPattern)):
                AllScripts.Add(script.name, script as AttackPattern)
                Debug.Log(script.name)
        

        Debug.Log(AllScripts.Count.ToString())