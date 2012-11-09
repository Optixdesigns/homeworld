import UnityEngine

/*

Setup AIBehavior in an gameobject

*/

[CustomEditor(typeof(AIBehaviors))]
public class AIBehaviorsEditor(RageToolsEditor): 
    
    private _aiBehaviors as AIBehaviors

    enum States:
        State1
        State2

    protected override def OnDrawInspectorHeaderLine():
        _aiBehaviors = target if _aiBehaviors == null

    protected override def OnDrawInspectorGUI():        
        EasyRow:
            LookLikeControls(50f, 10f)
            EasyIntField "Density Min", _aiBehaviors.MinVertexDensity

        for state in System.Enum.GetValues(States):
            #print state
            EasyRow:
                LookLikeControls(50f, 10f)
                EasyIntField "state", _aiBehaviors.MinVertexDensity
