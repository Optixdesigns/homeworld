import UnityEditor
import UnityEngine
import System.Collections
#import PGEditorUtils

[CustomEditor(typeof(AIAttackState))]
public class AIAttackStateInspector(Editor):

    // The main foldout state
    public expandEffects = true

    public override def OnInspectorGUI():
        script = (target cast AIAttackState)
        
        PGEditorUtils.LookLikeControls()
        EditorGUI.indentLevel = 1
        
        #self.target = PGEditorUtils.SerializedObjFoldOutList[of HitEffectGUIBacker]('EffectOnTargets   (May be inherited)', script._effectsOnTarget, self.expandEffects, script._editorListItemStates, true)
        script.target = PGEditorUtils.ObjectField[of Transform]("Target", script.target)
        
        GUILayout.Space(4)
        #script.debugLevel = (EditorGUILayout.EnumPopup('Debug Level', (script.debugLevel cast System.Enum)) cast DEBUG_LEVELS)
        
        // Flag Unity to save the changes to to the prefab to disk
        if GUI.changed:
            EditorUtility.SetDirty(target)

